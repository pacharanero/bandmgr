class SongsController < ApplicationController
  before_action :require_account
  before_action :set_song, only: %i[show edit update destroy]

  def index
    @query = params[:q].to_s.strip
    @tag_filter = params[:tag].to_s.strip
    @tags = current_account.tags.order(:name)
    update_sort_preferences
    @sort_field = current_user.song_sort
    @sort_direction = current_user.song_sort_direction
    @bands = current_account.bands.order(:name)
    @songs = policy_scope(Song).joins(:band).includes(:band).where(bands: { account_id: current_account.id })
    @setlists = policy_scope(Setlist).joins(:band).where(bands: { account_id: current_account.id }).order(:title)
    if @query.present?
      @songs = @songs.where("title ILIKE ? OR artist ILIKE ?", "%#{@query}%", "%#{@query}%")
    end
    if @tag_filter.present?
      @songs = @songs.joins(:tags).where(tags: { name: @tag_filter })
    end
    @songs = @songs.order(@sort_field => @sort_direction)
  end

  def show
    authorize @song
    @setlists = policy_scope(Setlist).joins(:band).where(bands: { account_id: current_account.id, id: @song.band_id }).order(:title)
  end

  def new
    @song = Song.new
    @song.band = preferred_band
    @song.tag_list = ""
    authorize @song
    load_bands
    load_band_memberships
  end

  def create
    @song = build_song_from_params
    @song.tag_list = song_params[:tag_list].to_s
    authorize @song

    if @song.save
      assign_tags(@song)
      redirect_to @song, notice: "Song created."
    else
      load_bands
      load_band_memberships
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @song
    @song.tag_list = tag_list_for(@song)
    load_bands
    load_band_memberships
  end

  def update
    authorize @song
    @song.tag_list = song_params[:tag_list].to_s

    assign_song_band
    if @song.update(song_params.except(:tag_list, :band_id))
      assign_tags(@song)
      redirect_to @song, notice: "Song updated."
    else
      load_bands
      load_band_memberships
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @song
    @song.destroy
    redirect_to songs_path, notice: "Song deleted."
  end

  def import
    authorize Song
    load_bands
  end

  def run_import
    authorize Song
    load_bands

    input = import_input
    @format = params[:format_type].presence || "plain"
    @band = find_band_from_params
    if @band.nil?
      flash.now[:alert] = "Select a band to import into."
      render :import, status: :unprocessable_entity
      return
    end
    if input.blank?
      flash.now[:alert] = "Paste or upload song data to import."
      render :import, status: :unprocessable_entity
      return
    end

    entries = parse_import_entries(input, @format)
    created, errors = import_entries(entries, @band)

    if errors.any?
      flash.now[:alert] = errors.join(" ")
      render :import, status: :unprocessable_entity
    else
      redirect_to songs_path, notice: "Imported #{created} songs."
    end
  end

  private
    def set_song
      @song = policy_scope(Song).find(params[:id])
    end

    def song_params
      params.require(:song).permit(:band_id, :title, :artist, :album, :key, :tempo, :notes, :tag_list, :singer_band_membership_id, :singer_name, :duration_seconds)
    end

    def assign_tags(song)
      tag_names = song.tag_list.to_s.split(",").map { |name| name.strip.downcase }.reject(&:blank?).uniq
      tags = tag_names.map { |name| current_account.tags.find_or_create_by!(name: name) }
      song.tags = tags
    end

    def tag_list_for(song)
      song.tags.order(:name).pluck(:name).join(", ")
    end

    def update_sort_preferences
      sort_field = params[:sort].presence
      sort_direction = params[:direction].presence
      return if sort_field.blank? && sort_direction.blank?

      return unless User::SONG_SORT_FIELDS.include?(sort_field) && User::SONG_SORT_DIRECTIONS.include?(sort_direction)

      current_user.update(song_sort: sort_field, song_sort_direction: sort_direction)
    end

    def import_input
      if params[:file].present?
        params[:file].read
      else
        params[:data].to_s
      end
    end

    def parse_import_entries(input, format)
      case format
      when "csv"
        parse_csv_entries(input)
      when "markdown"
        parse_line_entries(input, strip_markdown: true)
      else
        parse_line_entries(input, strip_markdown: false)
      end
    end

    def parse_line_entries(input, strip_markdown:)
      input.lines.map do |line|
        raw = line.strip
        next if raw.blank?

        raw = raw.sub(/^\d+\.\s+/, "").sub(/^[\-\*]\s+/, "") if strip_markdown
        title, artist = split_title_and_artist(raw)
        { title: title, artist: artist }
      end.compact
    end

    def parse_csv_entries(input)
      require "csv"

      CSV.parse(input, headers: false).filter_map do |row|
        next if row.compact.empty?

        title = row[0].to_s.strip
        next if title.blank?

        artist = row[1].to_s.strip.presence
        {
          title: title,
          artist: artist,
          key: row[2].to_s.strip.presence,
          tempo: row[3].to_s.strip.presence,
          notes: row[4].to_s.strip.presence
        }
      end
    end

    def split_title_and_artist(raw_title)
      if raw_title.include?(" - ")
        title, artist = raw_title.split(" - ", 2)
        [ title.strip, artist.to_s.strip.presence ]
      else
        [ raw_title.strip, nil ]
      end
    end

    def import_entries(entries, band)
      created = 0
      errors = []

      entries.each do |entry|
        song = band.songs.new(entry.except(:tag_list))
        song.tag_list = entry[:tag_list].to_s

        if song.save
          assign_tags(song)
          created += 1
        else
          errors << "Could not import '#{entry[:title]}' (#{song.errors.full_messages.to_sentence})."
        end
      end

      [ created, errors ]
    end

    def load_bands
      @bands = current_account.bands.order(:name)
    end

    def load_band_memberships
      @band_memberships = current_account
        .bands
        .includes(band_memberships: :user)
        .flat_map(&:band_memberships)
        .select { |bm| bm.user.present? }
        .uniq(&:id)
        .sort_by { |bm| bm.user.email_address }
    end
    def find_band_from_params
      band_id = params[:band_id].presence
      band_id ||= song_params[:band_id] if params[:song].present?
      return if band_id.blank?

      current_account.bands.find_by(id: band_id)
    end

    def build_song_from_params
      band = find_band_from_params
      song = Song.new(song_params.except(:tag_list))
      song.band = band if band
      song
    end

    def assign_song_band
      band = find_band_from_params
      @song.band = band if band
    end
end
