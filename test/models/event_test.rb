require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "requires a start time" do
    event = Event.new(band: bands(:one), kind: :gig)

    assert_not event.valid?
    assert_includes event.errors[:starts_at], "can't be blank"
  end
end
