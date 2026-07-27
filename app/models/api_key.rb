class ApiKey < ApplicationRecord
  belongs_to :user
  belongs_to :band, optional: true

  has_secure_token :token, length: 32

  validates :name, presence: true
  validates :scopes, presence: true
  validate :scopes_are_valid
  validate :cannot_expire_in_past
  validate :not_revoked_when_used

  scope :active, -> { where(revoked_at: nil).where("expires_at IS NULL OR expires_at > ?", Time.current) }

  PERMISSIONS = %w[read write delete].freeze

  def scoped_to_band?
    band_id.present?
  end

  def can?(permission)
    return false if revoked_at.present?
    return false if expires_at.present? && expires_at <= Time.current
    return false unless permission.in?(PERMISSIONS)

    scopes_array.include?(permission) || all_permissions?
  end

  def mark_used!
    update_column(:last_used_at, Time.current)
  end

  def revoke!
    update_column(:revoked_at, Time.current)
  end

  private

    def scopes_array
      scopes.split(",")
    end

    def all_permissions?
      scopes_array.include?("all")
    end

    def scopes_are_valid
      return if scopes.blank?

      invalid = scopes.split(",").reject { |s| s.in?(PERMISSIONS + ["all"]) }
      errors.add(:scopes, "contains invalid permissions: #{invalid.join(", ")}") if invalid.any?
    end

    def cannot_expire_in_past
      return unless expires_at.present? && expires_at <= Time.current

      errors.add(:expires_at, "cannot be in the past")
    end

    def not_revoked_when_used
      return unless revoked_at.present? && last_used_at.present? && last_used_at > revoked_at

      errors.add(:revoked_at, "cannot revoke a key that has been used since revocation")
    end
end
