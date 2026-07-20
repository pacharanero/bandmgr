require "test_helper"

class StyleGuidesControllerTest < ActionDispatch::IntegrationTest
  test "shows the style guide to an account owner" do
    sign_in_as users(:one)

    get style_guide_path

    assert_response :success
    assert_select "h1", "Style guide"
  end
end
