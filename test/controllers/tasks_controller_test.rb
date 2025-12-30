require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get tasks_path
    assert_redirected_to new_session_path
  end

  test "shows index for account member" do
    sign_in_as users(:one)

    get tasks_path
    assert_response :success
  end
end
