class BandMembershipInvitationsController < ApplicationController
  def show
    @membership = BandMembership.find_by!(invitation_token: params[:token])

    unless current_user
      redirect_to new_session_path, alert: "Sign in to accept the invitation." and return
    end

    if @membership.user_id.present? && @membership.user_id != current_user.id
      redirect_to root_path, alert: "This invitation is not for your account." and return
    end

    if @membership.invited_email.present? && @membership.invited_email != current_user.email_address.downcase
      redirect_to root_path, alert: "This invitation is not for your account." and return
    end

    if @membership.accepted?
      redirect_to @membership.band, notice: "Invitation already accepted." and return
    end

    ActiveRecord::Base.transaction do
      @membership.update!(user: current_user, invited_email: nil, invitation_accepted_at: Time.current)

      @membership.band.account.memberships.find_or_create_by!(user: current_user) do |membership|
        membership.role = :member
      end
    end

    redirect_to @membership.band, notice: "Invitation accepted."
  end
end
