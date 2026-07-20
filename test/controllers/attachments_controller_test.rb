require "test_helper"

class AttachmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
    @event.attachments.attach(io: StringIO.new("private document"), filename: "private.txt", content_type: "text/plain")
    @attachment = @event.attachments.first
  end

  test "downloads an attachment for an authorised account member" do
    sign_in_as users(:one)

    get attachment_path(@attachment)

    assert_response :success
    assert_equal "private document", response.body
  end

  test "does not expose an attachment to a member of another account" do
    sign_in_as users(:two)

    get attachment_path(@attachment)

    assert_response :not_found
  end
end
