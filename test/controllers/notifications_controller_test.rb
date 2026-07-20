require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "shows only the current user's notifications" do
    task = Task.create!(band: bands(:one), creator: users(:one), title: "Book transport")
    Notification.create!(user: users(:one), actor: users(:one), notifiable: task, kind: :task_assigned)
    Notification.create!(user: users(:two), actor: users(:two), notifiable: task, kind: :task_assigned)
    sign_in_as users(:one)

    get notifications_path

    assert_response :success
    assert_select "p", text: "Task assigned", count: 1
  end
end
