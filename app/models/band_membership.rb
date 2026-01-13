class BandMembership < ApplicationRecord
  belongs_to :band
  belongs_to :user, optional: true

  enum :role, { band_admin: 0, member: 1, read_only: 2 }, default: :member

  has_secure_token :invitation_token

  before_validation :normalize_invited_email

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :band_id }, allow_nil: true
  validates :invited_email, uniqueness: { scope: :band_id, case_sensitive: false }, allow_nil: true
  validates :invitation_token, uniqueness: true, allow_nil: true
  validate :user_or_invited_email_present

  after_create_commit :send_invitation

  def accepted?
    invitation_accepted_at.present?
  end

  def recipient_email
    user&.email_address || invited_email
  end

  def resend_invitation
    send_invitation
  end

  private

  def send_invitation
    return unless recipient_email

    update_column(:invitation_sent_at, Time.current)
    BandMembershipMailer.with(membership: self).invitation.deliver_later
  end

  def normalize_invited_email
    self.invited_email = invited_email.to_s.strip.downcase.presence
  end

  def user_or_invited_email_present
    return if user_id.present? || invited_email.present?

    errors.add(:base, "Provide an email to invite or select an existing user")
  end
end
