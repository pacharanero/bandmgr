require "test_helper"

class PublicSitesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @band.update!(public_site_enabled: true, public_domain: "example-band.test", public_site_markdown: "# {{ bandName }}\n\n{{ gigList | future }}")
  end

  test "renders an opted-in band's website for its domain" do
    Event.create!(band: @band, kind: :gig, starts_at: 1.day.from_now, venue: "The Test Venue")
    host! @band.public_domain

    get root_path

    assert_response :success
    assert_select "h1", @band.name
    assert_select "h1 a", count: 0
    assert_select "li", /The Test Venue/
  end

  test "does not render the public site on another domain" do
    host! "another-band.test"

    get root_path

    assert_redirected_to new_session_path
  end
end
