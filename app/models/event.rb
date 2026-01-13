class Event < ApplicationRecord
  belongs_to :band

  has_many :event_setlists, dependent: :destroy
  has_many :setlists, through: :event_setlists

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many_attached :attachments

  enum :kind, { gig: 0, rehearsal: 1 }, default: :gig

  validates :kind, presence: true
  validates :starts_at, presence: true
end
