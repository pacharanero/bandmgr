class User < ApplicationRecord
  SONG_SORT_FIELDS = %w[title artist album tempo].freeze
  SONG_SORT_DIRECTIONS = %w[asc desc].freeze

  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :accounts, through: :memberships
  has_many :band_memberships, dependent: :destroy
  has_many :bands, through: :band_memberships
  has_many :tasks_created, class_name: "Task", foreign_key: :creator_id, dependent: :restrict_with_exception, inverse_of: :creator
  has_many :tasks_assigned, class_name: "Task", foreign_key: :assignee_id, dependent: :nullify, inverse_of: :assignee
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :push_subscriptions, dependent: :destroy
  has_many :notifications_created, class_name: "Notification", foreign_key: :actor_id, dependent: :nullify, inverse_of: :actor

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :song_sort, inclusion: { in: SONG_SORT_FIELDS }
  validates :song_sort_direction, inclusion: { in: SONG_SORT_DIRECTIONS }
end
