class Setlist < ApplicationRecord
  belongs_to :account
  belongs_to :band

  has_many :setlist_songs, dependent: :destroy
  has_many :songs, through: :setlist_songs

  has_many :event_setlists, dependent: :destroy
  has_many :events, through: :event_setlists

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  before_validation :sync_account_from_band

  validates :title, presence: true
  validate :account_matches_band

  def copy
    copy = dup
    copy.title = "#{title} (Copy)"
    copy.save!

    setlist_songs.order(:position).each do |setlist_song|
      copy.setlist_songs.create!(song: setlist_song.song, position: setlist_song.position)
    end

    copy.tags = tags
    copy
  end

  private

  def sync_account_from_band
    self.account_id ||= band&.account_id
  end

  def account_matches_band
    return if band.nil? || account_id == band.account_id

    errors.add(:account_id, "must match the band account")
  end
end
