module Attachable
  extend ActiveSupport::Concern

  MAX_ATTACHMENT_SIZE = 20.megabytes
  ALLOWED_ATTACHMENT_TYPES = %w[
    application/pdf
    application/rtf
    application/msword
    application/vnd.oasis.opendocument.text
    application/vnd.openxmlformats-officedocument.wordprocessingml.document
    image/heic
    image/jpeg
    image/png
    image/webp
    text/plain
  ].freeze

  included do
    has_many_attached :attachments

    validate :attachments_are_allowed
  end

  private

    def attachments_are_allowed
      attachments.each do |attachment|
        if attachment.byte_size > MAX_ATTACHMENT_SIZE
          errors.add(:attachments, "must be #{MAX_ATTACHMENT_SIZE / 1.megabyte} MB or smaller")
        end

        next if ALLOWED_ATTACHMENT_TYPES.include?(attachment.content_type)

        errors.add(:attachments, "must be a PDF, text document, or image")
      end
    end
end
