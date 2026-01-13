class BandMembershipInvitationsController < ApplicationController
  def show
    @membership = BandMembership.find_by!(invitation_token: params[:token])

    unless @membership.user_id == current_user&.id
      redirect_to new_session_path, alert: "Sign in with the invited account to accept." and return unless current_user
      redirect_to root_path, alert: "This invitation is not for your account." and return
    end

    if @membership.accepted?
      redirect_to @membership.band, notice: "Invitation already accepted." and return
    end

    @membership.update!(invitation_accepted_at: Time.current)
    redirect_to @membership.band, notice: "Invitation accepted."
  end
end
