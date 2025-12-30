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
end
