class Song < ApplicationRecord
  belongs_to :account
  belongs_to :band

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :setlist_songs, dependent: :destroy
  has_many :setlists, through: :setlist_songs

  belongs_to :singer_band_membership, class_name: "BandMembership", optional: true

  attr_accessor :tag_list

  before_validation :sync_account_from_band

  validates :title, presence: true
  validates :band, presence: true
  validate :singer_belongs_to_account
  validate :account_matches_band

  def singer_display_name
    singer_name.presence || singer_band_membership&.user&.email_address
  end

  private

  def sync_account_from_band
    self.account_id ||= band&.account_id
  end

  def account_matches_band
    return if band.nil? || account_id == band.account_id

    errors.add(:account_id, "must match the band account")
  end

  def singer_belongs_to_account
    return if singer_band_membership.nil?
    return if singer_band_membership.band_id == band_id

    errors.add(:singer_band_membership, "must belong to the same band as the song")
  end
end
