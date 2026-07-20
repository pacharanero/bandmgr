class Band < ApplicationRecord
  belongs_to :account
  has_many :band_memberships, dependent: :destroy
  has_many :users, through: :band_memberships
  has_many :events, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :setlists, dependent: :destroy
  has_many :chat_channels, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many_attached :gallery_images

  has_secure_token :private_calendar_token
  has_secure_token :public_calendar_token

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true
  validates :public_contact_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :public_domain, format: { with: /\A(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,63}\z/ }, allow_blank: true
  validates :public_domain, presence: true, if: :public_site_enabled?
  validates :public_domain, uniqueness: true, allow_blank: true
  validate :gallery_images_are_allowed
  validate :public_urls_are_https

  before_validation :normalize_public_domain

  private

    def normalize_public_domain
      self.public_domain = public_domain.to_s.strip.downcase.delete_suffix(".").presence
    end

    def gallery_images_are_allowed
      gallery_images.each do |image|
        errors.add(:gallery_images, "must be a JPEG, PNG, WebP, or HEIC image") unless %w[image/heic image/jpeg image/png image/webp].include?(image.content_type)
        errors.add(:gallery_images, "must be 20 MB or smaller") if image.byte_size > 20.megabytes
      end
    end

    def public_urls_are_https
      %i[bandcamp facebook instagram soundcloud twitter youtube merch_url].each do |attribute|
        value = public_send(attribute)
        next if value.blank?

        uri = URI.parse(value)
        next if uri.is_a?(URI::HTTPS) && uri.host.present?

        errors.add(attribute, "must use HTTPS")
      rescue URI::InvalidURIError
        errors.add(attribute, "must use HTTPS")
      end
    end
end
