require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "requires a name" do
    tag = Tag.new(account: accounts(:one))

    assert_not tag.valid?
    assert_includes tag.errors[:name], "can't be blank"
  end

  test "normalizes name" do
    tag = Tag.new(account: accounts(:one), name: "  ROCK  ")

    tag.valid?
    assert_equal "rock", tag.name
  end

  test "enforces unique name per account" do
    tag = Tag.new(account: accounts(:one), name: tags(:one).name.upcase)

    assert_not tag.valid?
    assert_includes tag.errors[:name], "has already been taken"
  end
end
