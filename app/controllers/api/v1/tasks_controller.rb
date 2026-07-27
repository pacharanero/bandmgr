class Api::V1::TasksController < Api::V1::BaseController
  before_action :set_task, only: %i[show update destroy]
  after_action :verify_authorized, except: :index

  def index
    authorize Task
    @tasks = policy_scope(Task).joins(:band).where(bands: { account_id: current_account.id }).order(created_at: :desc)
    render json: @tasks
  end

  def show
    authorize @task
    render json: @task
  end

  def create
    @task = Task.new(task_params.merge(creator: current_user))
    authorize @task

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @task
    check_api_permission("write")

    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @task
    check_api_permission("delete")

    @task.destroy
    head :no_content
  end

  private

    def set_task
      @task = policy_scope(Task).find(params[:id])
    end

    def task_params
      params.require(:task).permit(:band_id, :title, :description, :status, :assignee_id, :due_at)
    end
end
