class Api::V1::AttachmentsController < Api::V1::BaseController
  before_action :set_attachable
  after_action :verify_authorized

  def index
    authorize @attachable, :show?
    @attachments = @attachable.attachments
    render json: @attachments.map { |a| attachment_json(a) }
  end

  def create
    authorize @attachable, :update?
    check_api_permission("write")

    @attachment = @attachable.attachments.attach(params[:attachment]).first
    if @attachment.attached?
      render json: attachment_json(@attachment), status: :created
    else
      render json: { errors: [ "Failed to attach file" ] }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @attachable, :update?
    check_api_permission("delete")

    attachment = @attachable.attachments.find(params[:id])
    attachment.purge
    head :no_content
  end

  private

    def set_attachable
      if params[:song_id]
        @attachable = policy_scope(Song).find(params[:song_id])
      elsif params[:event_id]
        @attachable = policy_scope(Event).find(params[:event_id])
      elsif params[:setlist_id]
        @attachable = policy_scope(Setlist).find(params[:setlist_id])
      else
        render json: { error: "Bad Request", message: "Missing attachable resource" }, status: :bad_request
      end
    end

    def attachment_json(attachment)
      {
        id: attachment.id,
        filename: attachment.filename,
        content_type: attachment.content_type,
        byte_size: attachment.byte_size,
        url: url_for(attachment)
      }
    end
end
