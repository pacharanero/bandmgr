class PushSubscription < ApplicationRecord
  belongs_to :user

  validates :endpoint, :p256dh, :auth, presence: true
  validates :endpoint, uniqueness: true
  validate :endpoint_must_be_https

  private

    def endpoint_must_be_https
      uri = URI.parse(endpoint)
      return if uri.is_a?(URI::HTTPS) && uri.host.present?

      errors.add(:endpoint, "must use HTTPS")
    rescue URI::InvalidURIError
      errors.add(:endpoint, "must use HTTPS")
    end
end
