class Event < ApplicationRecord
  belongs_to :band

  enum :kind, { gig: 0, rehearsal: 1 }, default: :gig

  validates :kind, presence: true
  validates :starts_at, presence: true
end
