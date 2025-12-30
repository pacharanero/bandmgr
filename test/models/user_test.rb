require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires an email address" do
    user = User.new(password: "secret", password_confirmation: "secret")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "normalizes email address" do
    user = User.new(email_address: "TEST@EXAMPLE.COM", password: "secret", password_confirmation: "secret")

    user.valid?
    assert_equal "test@example.com", user.email_address
  end

  test "enforces unique email address" do
    user = User.new(email_address: users(:one).email_address, password: "secret", password_confirmation: "secret")

    assert_not user.valid?
    assert_includes user.errors[:email_address], "has already been taken"
  end
end
