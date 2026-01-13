class SetlistsController < ApplicationController
  before_action :require_account
  before_action :set_setlist, only: %i[show edit update destroy duplicate print export]

  def index
    @setlists = policy_scope(Setlist)
      .joins(:band)
      .includes(:setlist_songs, :band)
      .where(bands: { account_id: current_account.id })
      .order(created_at: :desc)
  end

  def show
    authorize @setlist
    @setlist_songs = @setlist.setlist_songs.includes(:song).order(:position)
    @songs = @setlist.band.songs.order(:title)
  end

  def print
    authorize @setlist
    load_print_data
    render layout: "print"
  end

  def export
    authorize @setlist
    load_print_data
    pdf = SetlistPdf.new(setlist: @setlist, songs: @setlist_songs, settings: @print_settings).render
    send_data pdf,
      filename: "#{@setlist.title.to_s.parameterize}-setlist.pdf",
      type: "application/pdf"
  end

  def new
    @setlist = Setlist.new
    authorize @setlist
    load_bands
    @setlist.band ||= @selected_band
  end

  def create
    load_bands
    band = find_setlist_band
    @setlist = Setlist.new(setlist_params.except(:band_id))
    @setlist.band = band if band
    authorize @setlist

    if @setlist.save
      redirect_to @setlist, notice: "Setlist created."
    else
      load_bands
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @setlist
    load_bands
    @selected_band ||= @setlist.band
  end

  def update
    authorize @setlist
    assign_setlist_band

    if @setlist.update(setlist_params.except(:band_id))
      redirect_to @setlist, notice: "Setlist updated."
    else
      load_bands
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @setlist
    @setlist.destroy
    redirect_to setlists_path, notice: "Setlist deleted."
  end

  def duplicate
    authorize @setlist
    copy = @setlist.copy
    redirect_to edit_setlist_path(copy), notice: "Setlist duplicated."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @setlist, alert: e.message
  end

  def import
    authorize Setlist
    load_bands
  end

  def run_import
    authorize Setlist
    load_bands

    @playlist_url = params[:playlist_url].to_s.strip
    @title_override = params[:title].to_s.strip
    @description = params[:description].to_s.strip
    band_id = params[:band_id].presence || @selected_band&.id

    if @playlist_url.blank? || band_id.blank?
      flash.now[:alert] = "Select a band and provide a playlist URL."
      render :import, status: :unprocessable_entity
      return
    end

    band = current_account.bands.find_by(id: band_id)
    unless band
      flash.now[:alert] = "Select a band you have access to."
      render :import, status: :unprocessable_entity
      return
    end

    result = PlaylistImporter.new(
      url: @playlist_url,
      account: current_account,
      band: band,
      title: @title_override.presence,
      description: @description.presence
    ).import!

    redirect_to result.setlist, notice: "Imported #{result.created_count} songs (#{result.existing_count} already existed)."
  rescue PlaylistImporter::ImportError => e
    flash.now[:alert] = e.message
    render :import, status: :unprocessable_entity
  end

  private
    def set_setlist
      @setlist = policy_scope(Setlist).find(params[:id])
    end

    def setlist_params
      params.require(:setlist).permit(:band_id, :title, :description)
    end

    def load_bands
      @bands = current_account.bands.order(:name)
      @selected_band = preferred_band(@bands)
    end

    def assign_setlist_band
      return if setlist_params[:band_id].blank?

      @setlist.band = current_account.bands.find(setlist_params[:band_id])
    end

    def find_setlist_band
      band_id = setlist_params[:band_id].presence || @selected_band&.id
      current_account.bands.find_by(id: band_id)
    end

    def load_print_data
      @setlist_songs = @setlist.setlist_songs.includes(song: :tags).order(:position)
      @print_settings = {
        artist: truthy_param?(params[:artist]),
        key: truthy_param?(params[:key]),
        tempo: truthy_param?(params[:tempo]),
        notes: truthy_param?(params[:notes]),
        tags: truthy_param?(params[:tags]),
        duration: truthy_param?(params[:duration])
      }
      set_default_print_settings
    end

    def truthy_param?(value)
      value == "1" || value == "true"
    end

    def set_default_print_settings
      return if params.key?(:artist) || params.key?(:key) || params.key?(:tempo) || params.key?(:notes) || params.key?(:tags) || params.key?(:duration)

      @print_settings[:artist] = true
      @print_settings[:key] = true
      @print_settings[:tempo] = true
    end
end
