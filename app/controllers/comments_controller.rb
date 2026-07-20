class CommentsController < ApplicationController
  before_action :require_account
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params.merge(band: @commentable.band, user: current_user))
    authorize @comment

    if @comment.save
      notify_band_members
      redirect_to commentable_path, notice: "Comment added."
    else
      redirect_to commentable_path, alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

    def set_commentable
      @commentable = policy_scope(commentable_class).find(params[:commentable_id])
    end

    def commentable_class
      type = params[:commentable_type]
      raise ActionController::RoutingError, "Not Found" unless Comment::COMMENTABLE_TYPES.include?(type)

      type.constantize
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

    def notify_band_members
      Notification.create_for(users: @commentable.band.users, actor: current_user, notifiable: @comment, kind: :comment_added)
    end

    def commentable_path
      case @commentable
      when Task then tasks_path(band_id: @commentable.band_id)
      else polymorphic_path(@commentable)
      end
    end
end
