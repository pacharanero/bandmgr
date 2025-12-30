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
end
