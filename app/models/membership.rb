class Membership < ApplicationRecord
  belongs_to :account
  belongs_to :user

  enum :role, { owner: 0, admin: 1, member: 2 }, default: :member

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :account_id }
end
