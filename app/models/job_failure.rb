class JobFailure < ApplicationRecord
  validates :job_class, :active_job_id, :error_class, :message, :occurred_at, presence: true
end
