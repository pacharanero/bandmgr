class BandMembershipMailer < ApplicationMailer
  def invitation
    @membership = params.fetch(:membership)
    @band = @membership.band
    @accept_url = band_membership_invitation_url(@membership.invitation_token)

    mail to: @membership.recipient_email, subject: "You're invited to join #{@band.name} on Bandmgr"
  end
end
