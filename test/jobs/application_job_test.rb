require "test_helper"

class ApplicationJobTest < ActiveJob::TestCase
  class FailingJob < ApplicationJob
    def perform
      raise "Expected failure"
    end
  end

  test "records a failed job without its arguments" do
    assert_raises(RuntimeError) { FailingJob.perform_now }

    failure = JobFailure.last
    assert_equal "ApplicationJobTest::FailingJob", failure.job_class
    assert_equal "RuntimeError", failure.error_class
    assert_equal "Expected failure", failure.message
  end
end
