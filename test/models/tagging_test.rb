require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  test "enforces unique tag per taggable" do
    tagging = Tagging.new(tag: tags(:one), taggable: songs(:one))

    assert_not tagging.valid?
    assert_includes tagging.errors[:tag_id], "has already been taken"
  end
end
