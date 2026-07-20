require "test_helper"

class PublicSites::RendererTest < ActiveSupport::TestCase
  test "renders safe Markdown with current band data" do
    band = bands(:one)
    band.update!(name: "The **Example** Band", description: "A test band", public_contact_email: "booking@example.test", merch_url: "https://shop.example.test", public_site_markdown: "# {{ bandName }}\n\n{{ description }}\n\n{{ contact }}\n\n{{ gigList | future }}\n\n{{ merchUrl }}\n\n<script>alert(1)</script>")
    Event.create!(band:, kind: :gig, starts_at: 1.day.from_now, venue: "Example Club")

    html = PublicSites::Renderer.new(band).render

    assert_includes html, "The **Example** Band"
    assert_includes html, "A test band"
    assert_includes html, "mailto:booking@example.test"
    assert_includes html, "Example Club"
    assert_includes html, "https://shop.example.test"
    assert_not_includes html, "<script>"
  end

  test "does not render unsafe Markdown links" do
    band = bands(:one)
    band.update!(public_site_markdown: "[Unsafe](javascript:alert(1))")

    html = PublicSites::Renderer.new(band).render

    assert_not_includes html, "javascript:"
  end
end
