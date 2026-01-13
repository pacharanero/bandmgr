class Membership < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :default_band, class_name: "Band", optional: true

  enum :role, { owner: 0, admin: 1, member: 2 }, default: :member

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :account_id }
  validate :default_band_within_account

  private

  def default_band_within_account
    return if default_band.nil?

    errors.add(:default_band, "must belong to the same account") unless default_band.account_id == account_id
  end
end
