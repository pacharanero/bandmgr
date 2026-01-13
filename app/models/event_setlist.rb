class EventSetlist < ApplicationRecord
  belongs_to :event
  belongs_to :setlist

  validate :event_and_setlist_share_band_account

  private

  def event_and_setlist_share_band_account
    return if event.nil? || setlist.nil?
    return if event.band_id == setlist.band_id && event.band.account_id == setlist.account_id

    errors.add(:setlist_id, "must belong to the same band/account as the event")
  end
end
