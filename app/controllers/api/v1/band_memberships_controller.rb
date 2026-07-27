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
    @membership = @band.band_memberships.new
    @membership.user = find_user_from_email
    @membership.invited_email = membership_params[:email_address] if @membership.user.nil?
    authorize @membership

    requested_role = sanitized_role_param
    return render_forbidden_role if requested_role == "band_admin" && !current_user_band_admin?

    @membership.role = requested_role

    if @membership.user
      @band.account.memberships.find_or_create_by!(user: @membership.user) do |membership|
        membership.role = :member
      end
    end

    if @membership.save
      render json: @membership, status: :created
    else
      render json: { errors: @membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @membership
    check_api_permission("write")

    requested_role = sanitized_role_param
    return render_forbidden_role if requested_role == "band_admin" && !current_user_band_admin?

    if @membership.update(role: requested_role)
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
      params.require(:band_membership).permit(:email_address)
    end

    def sanitized_role_param
      role = params.dig(:band_membership, :role).to_s
      allowed = %w[member read_only]
      allowed << "band_admin" if current_user_band_admin?
      allowed.include?(role) ? role : "member"
    end

    def current_user_band_admin?
      return false unless current_user

      @band.band_memberships.where(user_id: current_user.id, role: :band_admin).exists?
    end

    def find_user_from_email
      email = membership_params[:email_address].to_s.strip.downcase
      return if email.blank?

      User.find_by(email_address: email)
    end

    def render_forbidden_role
      render json: { error: "Forbidden", message: "Only a band admin can assign the band admin role" }, status: :forbidden
    end
end
