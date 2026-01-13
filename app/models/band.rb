class Band < ApplicationRecord
  belongs_to :account
  has_many :band_memberships, dependent: :destroy
  has_many :users, through: :band_memberships
  has_many :events, dependent: :destroy
  has_many :setlists, dependent: :destroy

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true
end
