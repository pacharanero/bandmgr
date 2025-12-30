class BandsController < ApplicationController
  before_action :require_account
  before_action :set_band, only: %i[show edit update destroy]

  def index
    @bands = policy_scope(Band).where(account: current_account)
    authorize Band
  end

  def show
    authorize @band
    @memberships = @band.band_memberships.includes(:user).order(:id)
    @band_membership = @band.band_memberships.new
  end

  def new
    @band = current_account.bands.new
    authorize @band
  end

  def create
    @band = current_account.bands.new(band_params)
    authorize @band

    if @band.save
      @band.band_memberships.create!(user: current_user, role: :band_admin)
      redirect_to @band, notice: "Band created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @band
  end

  def update
    authorize @band

    if @band.update(band_params)
      redirect_to @band, notice: "Band updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @band
    @band.destroy
    redirect_to bands_path, notice: "Band removed."
  end

  private
    def set_band
      @band = policy_scope(Band).find(params[:id])
    end

    def band_params
      params.require(:band).permit(:name, :description)
    end
end
