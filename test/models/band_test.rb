require "test_helper"

class BandTest < ActiveSupport::TestCase
  test "requires a name" do
    band = Band.new(account: accounts(:one))

    assert_not band.valid?
    assert_includes band.errors[:name], "can't be blank"
  end
end
