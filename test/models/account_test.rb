require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "requires a name and slug" do
    account = Account.new

    assert_not account.valid?
    assert_includes account.errors[:name], "can't be blank"
    assert_includes account.errors[:slug], "can't be blank"
  end

  test "enforces unique slugs" do
    account = Account.new(name: "Another", slug: accounts(:one).slug)

    assert_not account.valid?
    assert_includes account.errors[:slug], "has already been taken"
  end

  test "encrypts AI API keys at rest" do
    secret = "test-openai-secret"
    account = Account.create!(name: "Encrypted", slug: "encrypted", ai_provider: "openai", ai_openai_api_key: secret)

    account.reload

    assert_equal secret, account.ai_openai_api_key
    assert_nil account[:ai_openai_api_key]
    refute_includes account.read_attribute_before_type_cast(:encrypted_ai_openai_api_key), secret
    assert_predicate account, :ai_enabled?
    assert_predicate account, :ai_configured?
  end

  test "requires a supported AI provider" do
    account = Account.new(name: "Unsupported", slug: "unsupported", ai_provider: "unknown")

    assert_not account.valid?
    assert_includes account.errors[:ai_provider], "is not included in the list"
  end
end
