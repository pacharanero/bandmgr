class ApplicationJob < ActiveJob::Base
  around_perform do |job, block|
    block.call
  rescue StandardError => error
    Rails.logger.error("background_job_failed job_class=#{job.class.name} active_job_id=#{job.job_id} error_class=#{error.class.name}")
    JobFailure.create!(
      job_class: job.class.name,
      active_job_id: job.job_id,
      error_class: error.class.name,
      message: error.message,
      occurred_at: Time.current
    )
    raise
  end

  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
