require "test_helper"

class PushSubscriptionTest < ActiveSupport::TestCase
  test "requires an HTTPS push endpoint" do
    subscription = PushSubscription.new(user: users(:one), endpoint: "https://push.example.test/subscription", p256dh: "public-key", auth: "auth-token")

    assert_predicate subscription, :valid?

    subscription.endpoint = "https://push.example.test\nnot-an-endpoint"

    assert_predicate subscription, :invalid?
    assert_includes subscription.errors[:endpoint], "must use HTTPS"
  end
end
