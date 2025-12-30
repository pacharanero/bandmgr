class Account < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :bands, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
