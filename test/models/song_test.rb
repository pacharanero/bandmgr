require "test_helper"

class SongTest < ActiveSupport::TestCase
  test "requires a title" do
    song = Song.new(account: accounts(:one))

    assert_not song.valid?
    assert_includes song.errors[:title], "can't be blank"
  end
end
