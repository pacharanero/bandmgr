class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_commentable
  after_action :verify_authorized

  def index
    authorize @commentable, :show?
    @comments = policy_scope(Comment).where(commentable: @commentable).includes(:user).order(:created_at)
    render json: @comments
  end

  def create
    @comment = @commentable.comments.new(comment_params.merge(user: current_user))
    authorize @comment

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

    def set_commentable
      if params[:song_id]
        @commentable = policy_scope(Song).find(params[:song_id])
      elsif params[:event_id]
        @commentable = policy_scope(Event).find(params[:event_id])
      elsif params[:task_id]
        @commentable = policy_scope(Task).find(params[:task_id])
      else
        render json: { error: "Bad Request", message: "Missing commentable resource" }, status: :bad_request
      end
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
