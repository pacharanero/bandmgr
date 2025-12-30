class BandMembership < ApplicationRecord
  belongs_to :band
  belongs_to :user

  enum :role, { band_admin: 0, member: 1, readonly: 2 }, default: :member

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :band_id }
end
