require "test_helper"

class BandTest < ActiveSupport::TestCase
  test "requires a name" do
    band = Band.new(account: accounts(:one))

    assert_not band.valid?
    assert_includes band.errors[:name], "can't be blank"
  end

  test "normalizes a public domain before validating it" do
    band = Band.new(account: accounts(:one), name: "Published", public_site_enabled: true, public_domain: "  EXAMPLE-BAND.TEST. ")

    assert_predicate band, :valid?
    assert_equal "example-band.test", band.public_domain
  end

  test "requires HTTPS public links" do
    band = Band.new(account: accounts(:one), name: "Published", merch_url: "http://shop.example.test")

    assert_predicate band, :invalid?
    assert_includes band.errors[:merch_url], "must use HTTPS"
  end
end
