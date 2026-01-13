class SetlistSong < ApplicationRecord
  belongs_to :setlist
  belongs_to :song

  validates :position, numericality: { greater_than_or_equal_to: 0 }
  validate :song_and_setlist_share_account

  private

  def song_and_setlist_share_account
    return if setlist.nil? || song.nil?
    return if setlist.account_id == song.account_id

    errors.add(:song_id, "must belong to the same account as the setlist")
  end
end
