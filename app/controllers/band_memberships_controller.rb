class BandMembershipsController < ApplicationController
  before_action :require_account
  before_action :set_band
  before_action :set_band_membership, only: %i[update destroy]

  def create
    @band_membership = @band.band_memberships.new(role: band_membership_params[:role])
    @band_membership.user = find_user_from_email
    authorize @band_membership

    if @band_membership.user.nil?
      @band_membership.errors.add(:base, "User not found. Ask them to sign up first.")
      render_band_membership_errors
      return
    end

    @band.account.memberships.find_or_create_by!(user: @band_membership.user) do |membership|
      membership.role = :member
    end

    if @band_membership.save
      redirect_to @band, notice: "Member added."
    else
      render_band_membership_errors
    end
  end

  def update
    authorize @band_membership

    if @band_membership.update(role: band_membership_params[:role])
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

  private
    def set_band
      @band = policy_scope(Band).find(params[:band_id])
    end

    def set_band_membership
      @band_membership = @band.band_memberships.find(params[:id])
    end

    def band_membership_params
      params.require(:band_membership).permit(:role, :email_address)
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
end
