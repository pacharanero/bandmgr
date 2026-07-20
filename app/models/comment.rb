class Comment < ApplicationRecord
  COMMENTABLE_TYPES = %w[Task Event Song].freeze

  belongs_to :band
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :body, presence: true
  validates :commentable_type, inclusion: { in: COMMENTABLE_TYPES }
  validate :band_matches_commentable

  private

    def band_matches_commentable
      return if commentable.nil? || band_id == commentable.band_id

      errors.add(:band, "must match the commented record's band")
    end
end
