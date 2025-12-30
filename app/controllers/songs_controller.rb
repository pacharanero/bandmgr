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
    @songs = policy_scope(Song).where(account: current_account)
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
  end

  def new
    @song = current_account.songs.new
    @song.tag_list = ""
    authorize @song
  end

  def create
    @song = current_account.songs.new(song_params.except(:tag_list))
    @song.tag_list = song_params[:tag_list].to_s
    authorize @song

    if @song.save
      assign_tags(@song)
      redirect_to @song, notice: "Song created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @song
    @song.tag_list = tag_list_for(@song)
  end

  def update
    authorize @song
    @song.tag_list = song_params[:tag_list].to_s

    if @song.update(song_params.except(:tag_list))
      assign_tags(@song)
      redirect_to @song, notice: "Song updated."
    else
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
  end

  def run_import
    authorize Song

    input = import_input
    @format = params[:format_type].presence || "plain"
    if input.blank?
      flash.now[:alert] = "Paste or upload song data to import."
      render :import, status: :unprocessable_entity
      return
    end

    entries = parse_import_entries(input, @format)
    created, errors = import_entries(entries)

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
      params.require(:song).permit(:title, :artist, :album, :key, :tempo, :notes, :tag_list)
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

        raw_title = row[0].to_s.strip
        next if raw_title.blank?

        title, artist = split_title_and_artist(raw_title)
        tags = parse_tag_field(row[2])
        {
          title: title,
          artist: artist,
          key: row[1].to_s.strip.presence,
          notes: row[3].to_s.strip.presence,
          tag_list: tags.join(", ")
        }
      end
    end

    def split_title_and_artist(raw_title)
      if raw_title.include?(" - ")
        title, artist = raw_title.split(" - ", 2)
        [title.strip, artist.to_s.strip.presence]
      else
        [raw_title.strip, nil]
      end
    end

    def parse_tag_field(raw)
      cleaned = raw.to_s.strip
      cleaned = cleaned.delete_prefix("[").delete_suffix("]")
      cleaned.split(/[,\s]+/).map(&:strip).reject(&:blank?).uniq
    end

    def import_entries(entries)
      created = 0
      errors = []

      entries.each do |entry|
        song = current_account.songs.new(entry.except(:tag_list))
        song.tag_list = entry[:tag_list].to_s

        if song.save
          assign_tags(song)
          created += 1
        else
          errors << "Could not import '#{entry[:title]}' (#{song.errors.full_messages.to_sentence})."
        end
      end

      [created, errors]
    end
end
