require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @member = User.create!(email_address: "task-member@example.com", password: "password", password_confirmation: "password")
    @account_only_user = User.create!(email_address: "task-account-only@example.com", password: "password", password_confirmation: "password")
    Membership.create!(account: accounts(:one), user: @member, role: :member)
    Membership.create!(account: accounts(:one), user: @account_only_user, role: :member)
    BandMembership.create!(band: @band, user: @member, role: :member)
  end

  test "creates a task and notifies its assignee" do
    sign_in_as users(:one)

    assert_difference([ "Task.count", "Notification.count" ], 1) do
      post tasks_path, params: {
        task: { band_id: @band.id, title: "Confirm rehearsal room", assignee_id: @member.id, status: "todo" }
      }
    end

    task = Task.last
    assert_redirected_to tasks_path(band_id: @band.id)
    assert_equal @member, task.assignee
    assert_equal "task_assigned", Notification.last.kind
    assert_equal @member, Notification.last.user
  end

  test "does not allow an account member outside the band to create a task" do
    sign_in_as @account_only_user

    assert_no_difference("Task.count") do
      post tasks_path, params: { task: { band_id: @band.id, title: "Private task" } }
    end

    assert_redirected_to root_path
  end

  test "does not show tasks from a band the user has not joined" do
    private_band = Band.create!(account: accounts(:one), name: "Private project")
    Task.create!(band: private_band, creator: users(:one), title: "Hidden task")
    sign_in_as users(:one)

    get tasks_path

    assert_response :success
    assert_select "body", text: /Hidden task/, count: 0
  end
end
