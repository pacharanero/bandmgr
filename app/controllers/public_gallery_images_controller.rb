class PublicGalleryImagesController < ApplicationController
  allow_unauthenticated_access only: :show

  def show
    skip_authorization
    image = ActiveStorage::Blob.find_signed!(params[:signed_id])
    band = Band.joins(:gallery_images_attachments).find_by!(active_storage_attachments: { blob_id: image.id, name: "gallery_images" })
    raise ActiveRecord::RecordNotFound unless band.public_site_enabled? && band.public_domain == request.host.downcase

    send_data image.download, filename: image.filename.to_s, type: image.content_type, disposition: "inline"
  end
end
