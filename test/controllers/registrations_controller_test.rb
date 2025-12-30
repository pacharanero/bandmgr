require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "renders sign up form" do
    get new_registration_path
    assert_response :success
  end

  test "creates a user and redirects to account setup" do
    assert_difference("User.count", 1) do
      post registration_path, params: {
        user: {
          email_address: "newuser@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    assert_redirected_to new_account_path
  end
end
