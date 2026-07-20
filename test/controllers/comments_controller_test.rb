require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @member = User.create!(email_address: "comment-member@example.com", password: "password", password_confirmation: "password")
    @account_only_user = User.create!(email_address: "comment-account-only@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: @member, role: :member)
    Membership.create!(account: accounts(:one), user: @account_only_user, role: :member)
    BandMembership.create!(band: @band, user: @member, role: :member)
    @task = Task.create!(band: @band, creator: users(:one), title: "Prepare set")
  end

  test "adds a task comment and notifies other band members" do
    sign_in_as @member

    assert_difference([ "Comment.count", "Notification.count" ], 1) do
      post comments_path, params: {
        commentable_type: "Task",
        commentable_id: @task.id,
        comment: { body: "I can bring the charts." }
      }
    end

    assert_redirected_to tasks_path(band_id: @band.id)
    assert_equal users(:one), Notification.last.user
    assert_equal "comment_added", Notification.last.kind
  end

  test "does not allow an account member outside the band to comment on a task" do
    sign_in_as @account_only_user

    assert_no_difference("Comment.count") do
      post comments_path, params: {
        commentable_type: "Task",
        commentable_id: @task.id,
        comment: { body: "Private reply" }
      }
    end

    assert_response :not_found
  end

  test "adds a comment to a song visible within the account" do
    sign_in_as users(:one)

    assert_difference("Comment.count", 1) do
      post comments_path, params: {
        commentable_type: "Song",
        commentable_id: songs(:one).id,
        comment: { body: "Use the acoustic arrangement." }
      }
    end

    assert_redirected_to song_path(songs(:one))
  end
end
