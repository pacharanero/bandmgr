class Tag < ApplicationRecord
  belongs_to :account

  has_many :taggings, dependent: :destroy

  normalizes :name, with: ->(name) { name.to_s.strip.downcase }

  validates :name, presence: true, uniqueness: { scope: :account_id, case_sensitive: false }
end
