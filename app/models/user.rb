class User < ApplicationRecord
  SONG_SORT_FIELDS = %w[title artist album tempo].freeze
  SONG_SORT_DIRECTIONS = %w[asc desc].freeze

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :band_memberships, dependent: :destroy
  has_many :bands, through: :band_memberships

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :song_sort, inclusion: { in: SONG_SORT_FIELDS }
  validates :song_sort_direction, inclusion: { in: SONG_SORT_DIRECTIONS }
end
