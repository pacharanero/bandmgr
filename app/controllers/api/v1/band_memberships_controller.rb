class Api::V1::BandMembershipsController < Api::V1::BaseController
  before_action :set_band
  before_action :set_membership, only: %i[update destroy]
  after_action :verify_authorized

  def index
    authorize @band, :show?
    @memberships = @band.band_memberships.includes(:user)
    render json: @memberships
  end

  def create
    @membership = @band.band_memberships.new(membership_params)
    authorize @membership

    if @membership.save
      render json: @membership, status: :created
    else
      render json: { errors: @membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @membership
    check_api_permission("write")

    if @membership.update(membership_params)
      render json: @membership
    else
      render json: { errors: @membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @membership
    check_api_permission("delete")

    @membership.destroy
    head :no_content
  end

  private

    def set_band
      @band = policy_scope(Band).find(params[:band_id])
    end

    def set_membership
      @membership = @band.band_memberships.find(params[:id])
    end

    def membership_params
      params.require(:band_membership).permit(:email_address, :role)
    end
end
