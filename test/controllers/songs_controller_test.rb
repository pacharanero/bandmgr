require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get songs_path
    assert_redirected_to new_session_path
  end

  test "shows index for account member" do
    sign_in_as users(:one)

    get songs_path
    assert_response :success
  end
end
