require "test_helper"

class SetlistsControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get setlists_path
    assert_redirected_to new_session_path
  end

  test "shows index for account member" do
    sign_in_as users(:one)

    get setlists_path
    assert_response :success
  end
end
