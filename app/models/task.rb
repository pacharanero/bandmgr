class Task < ApplicationRecord
  belongs_to :band
  belongs_to :creator, class_name: "User"
  belongs_to :assignee, class_name: "User", optional: true

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  enum :status, { todo: 0, in_progress: 1, done: 2 }, default: :todo

  validates :title, presence: true
  validate :assignee_belongs_to_band

  private

    def assignee_belongs_to_band
      return if assignee.nil? || band&.band_memberships&.exists?(user_id: assignee.id)

      errors.add(:assignee, "must belong to the task's band")
    end
end
