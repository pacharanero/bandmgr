require "test_helper"

class AttachableTest < ActiveSupport::TestCase
  test "rejects attachments with an unsupported content type" do
    event = events(:one)
    event.attachments.attach(io: StringIO.new("binary"), filename: "unsafe.exe", content_type: "application/octet-stream")

    assert_not event.valid?
    assert_includes event.errors[:attachments], "must be a PDF, text document, or image"
  end
end
