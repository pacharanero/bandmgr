require "test_helper"

class PushSubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "stores a browser push subscription for the signed-in user" do
    sign_in_as users(:one)

    assert_difference("PushSubscription.count", 1) do
      post push_subscriptions_path, params: { push_subscription: subscription_params }
    end

    assert_response :created
    assert_equal users(:one), PushSubscription.last.user
  end

  test "moves a browser subscription to the newly signed-in user" do
    PushSubscription.create!(user: users(:two), **subscription_params)
    sign_in_as users(:one)

    assert_no_difference("PushSubscription.count") do
      post push_subscriptions_path, params: { push_subscription: subscription_params }
    end

    assert_equal users(:one), PushSubscription.last.user
  end

  test "does not allow another user to remove a subscription" do
    subscription = PushSubscription.create!(user: users(:one), **subscription_params)
    sign_in_as users(:two)

    assert_no_difference("PushSubscription.count") do
      delete push_subscription_path(subscription)
    end

    assert_response :not_found
  end

  private

    def subscription_params
      {
        endpoint: "https://push.example.test/subscription",
        p256dh: "public-key",
        auth: "auth-token",
        last_used_at: Time.current
      }
    end
end
