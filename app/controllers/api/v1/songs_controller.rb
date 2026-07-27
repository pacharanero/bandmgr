class Api::V1::SongsController < Api::V1::BaseController
  before_action :set_song, only: %i[show update destroy]
  after_action :verify_authorized, except: :index

  def index
    authorize Song
    @songs = policy_scope(Song).where(account: current_account).order(:title)
    render json: @songs
  end

  def show
    authorize @song
    render json: @song
  end

  def create
    @song = current_account.songs.new(song_params)
    authorize @song

    if @song.save
      render json: @song, status: :created
    else
      render json: { errors: @song.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @song
    check_api_permission("write")

    if @song.update(song_params)
      render json: @song
    else
      render json: { errors: @song.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @song
    check_api_permission("delete")

    @song.destroy
    head :no_content
  end

  private

    def set_song
      @song = policy_scope(Song).find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :artist, :album, :key, :tempo, :duration, :notes, :band_id, tag_ids: [])
    end
end
