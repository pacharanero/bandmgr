require "test_helper"

class ApiKeyTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @band = bands(:one)
  end

  test "creates a token on creation" do
    api_key = ApiKey.create!(user: @user, name: "Test Key")

    assert api_key.token.present?
  end

  test "scopes default to read" do
    api_key = ApiKey.create!(user: @user, name: "Test Key")

    assert_equal "read", api_key.scopes
  end

  test "can check permissions" do
    api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "read,write")

    assert api_key.can?("read")
    assert api_key.can?("write")
    refute api_key.can?("delete")
  end

  test "all scope grants all permissions" do
    api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "all")

    assert api_key.can?("read")
    assert api_key.can?("write")
    assert api_key.can?("delete")
  end

  test "revoked key cannot be used" do
    api_key = ApiKey.create!(user: @user, name: "Test Key")
    api_key.revoke!

    refute api_key.can?("read")
  end

  test "expired key cannot be used" do
    api_key = ApiKey.create!(user: @user, name: "Test Key", expires_at: 1.hour.from_now)
    api_key.update_column(:expires_at, 1.hour.ago)

    refute api_key.can?("read")
  end

  test "validates scopes" do
    api_key = ApiKey.new(user: @user, name: "Test Key", scopes: "invalid")

    assert_not api_key.valid?
    assert_includes api_key.errors[:scopes].first, "invalid"
  end

  test "cannot expire in the past on update" do
    api_key = ApiKey.create!(user: @user, name: "Test Key")

    api_key.expires_at = 1.hour.ago
    assert_not api_key.valid?
    assert_includes api_key.errors[:expires_at].first, "past"
  end

  test "can be scoped to a band" do
    api_key = ApiKey.create!(user: @user, name: "Test Key", band: @band)

    assert api_key.scoped_to_band?
    assert_equal @band, api_key.band
  end
end
