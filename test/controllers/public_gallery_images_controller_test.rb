require "test_helper"

class PublicGalleryImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @band = bands(:one)
    @band.update!(public_site_enabled: true, public_domain: "example-band.test")
    @band.gallery_images.attach(io: StringIO.new("image content"), filename: "gallery.png", content_type: "image/png")
    @image = @band.gallery_images.first
  end

  test "serves a gallery image from the published band's domain" do
    host! @band.public_domain

    get public_gallery_image_path(@image.signed_id)

    assert_response :success
    assert_equal "image/png", response.media_type
  end

  test "does not serve a gallery image from another domain" do
    host! "another-band.test"

    get public_gallery_image_path(@image.signed_id)

    assert_response :not_found
  end
end
