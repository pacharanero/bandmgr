class BandsController < ApplicationController
  before_action :require_account
  before_action :set_band, only: %i[show edit update destroy set_default]

  def index
    @bands = policy_scope(Band).where(account: current_account)
    authorize Band
  end

  def show
    authorize @band
    @memberships = @band.band_memberships.includes(:user).order(:id)
    @band_membership = @band.band_memberships.new
    @default_band = current_account_membership&.default_band
    ensure_calendar_tokens
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
    ensure_calendar_tokens
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

  def set_default
    authorize @band

    membership = current_account_membership

    unless membership
      redirect_to @band, alert: "You need access to set a default band." and return
    end

    membership.update!(default_band: @band)
    redirect_to @band, notice: "Default band set."
  end

  private
    def set_band
      @band = policy_scope(Band).find(params[:id])
    end

    def band_params
      params.require(:band).permit(:name, :description, :public_calendar_enabled, :public_calendar_include_rehearsals)
    end

    def ensure_calendar_tokens
      updates = {}
      updates[:private_calendar_token] = @band.generate_unique_secure_token if @band.private_calendar_token.blank?
      updates[:public_calendar_token] = @band.generate_unique_secure_token if @band.public_calendar_token.blank?
      @band.update_columns(updates) if updates.any?
    end
end
