require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get new_account_path
    assert_redirected_to new_session_path
  end

  test "renders new for signed in user" do
    sign_in_as users(:one)
    get new_account_path
    assert_response :success
  end

  test "creates account and membership" do
    sign_in_as users(:one)

    assert_difference("Account.count", 1) do
      assert_difference("Membership.count", 1) do
        post accounts_path, params: { account: { name: "New Account", slug: "new-account" } }
      end
    end

    account = Account.last
    membership = Membership.last

    assert_equal account, membership.account
    assert_equal users(:one), membership.user
    assert_equal "owner", membership.role
  end
end
