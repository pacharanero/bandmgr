class BandMembershipsController < ApplicationController
  before_action :require_account
  before_action :set_band
  before_action :set_band_membership, only: %i[update destroy resend_invite]

  def create
    requested_role = sanitized_role_param
    if requested_role == "band_admin" && !current_user_band_admin?(@band)
      render_forbidden_role and return
    end

    @band_membership = @band.band_memberships.new(role: requested_role)
    @band_membership.user = find_user_from_email
    @band_membership.invited_email = band_membership_params[:email_address] if @band_membership.user.nil?
    authorize @band_membership

    if @band_membership.user
      @band.account.memberships.find_or_create_by!(user: @band_membership.user) do |membership|
        membership.role = :member
      end
    end

    if @band_membership.save
      redirect_to @band, notice: "Invitation sent."
    else
      render_band_membership_errors
    end
  end

  def update
    authorize @band_membership

    requested_role = sanitized_role_param
    if requested_role == "band_admin" && !current_user_band_admin?(@band)
      render_forbidden_role and return
    end

    if @band_membership.update(role: requested_role)
      redirect_to @band, notice: "Member updated."
    else
      render_band_membership_errors
    end
  end

  def destroy
    authorize @band_membership
    @band_membership.destroy
    redirect_to @band, notice: "Member removed."
  end

  def resend_invite
    authorize @band_membership

    if @band_membership.accepted?
      redirect_to @band, alert: "This member has already accepted."
      return
    end

    @band_membership.resend_invitation
    redirect_to @band, notice: "Invitation resent."
  end

  private
    def set_band
      @band = policy_scope(Band).find(params[:band_id])
    end

    def set_band_membership
      @band_membership = @band.band_memberships.find(params[:id])
    end

    def band_membership_params
      params.require(:band_membership).permit(:email_address)
    end

    def sanitized_role_param
      role = params.dig(:band_membership, :role).to_s
      allowed = %w[member read_only]
      allowed << "band_admin" if current_user_band_admin?(@band)
      allowed.include?(role) ? role : "member"
    end

    def current_user_band_admin?(band)
      return false unless current_user

      band.band_memberships.where(user_id: current_user.id, role: :band_admin).exists?
    end

    def find_user_from_email
      email = band_membership_params[:email_address].to_s.strip.downcase
      return if email.blank?

      User.find_by(email_address: email)
    end

    def render_band_membership_errors
      @memberships = @band.band_memberships.includes(:user).order(:id)
      render "bands/show", status: :unprocessable_entity
    end

    def render_forbidden_role
      @band_membership ||= @band.band_memberships.new
      @band_membership.errors.add(:role, "only a band admin can assign band admin role")
      render_band_membership_errors
    end
end
