class AttachmentsController < ApplicationController
  before_action :require_account
  before_action :set_attachment

  def show
    authorize @record, :show?

    send_data @attachment.download,
      filename: @attachment.filename.to_s,
      type: @attachment.content_type,
      disposition: "attachment"
  end

  def destroy
    authorize @record, :update?
    @attachment.purge_later
    redirect_to polymorphic_path(@record), notice: "Attachment removed."
  end

  private

    def set_attachment
      attachment = ActiveStorage::Attachment.includes(:blob).find(params[:id])
      record_class = case attachment.record_type
      when "Song" then Song
      when "Event" then Event
      when "Setlist" then Setlist
      else raise ActiveRecord::RecordNotFound
      end
      raise ActiveRecord::RecordNotFound unless attachment.name == "attachments"

      @record = policy_scope(record_class).find(attachment.record_id)
      @attachment = attachment
    end
end
