class TasksController < ApplicationController
  before_action :require_account
  before_action :set_task, only: %i[update destroy]
  after_action :verify_policy_scoped, only: :index

  def index
    authorize Task
    @bands = current_user.bands.where(account: current_account).order(:name)
    @selected_band = @bands.find_by(id: params[:band_id]) || preferred_band(@bands)
    @tasks = policy_scope(Task).includes(:band, :assignee, :creator).order(:status, created_at: :desc)
    @tasks = @tasks.where(band: @selected_band) if @selected_band
    @task = Task.new(band: @selected_band)
    @members = @selected_band ? @selected_band.users.order(:email_address) : User.none
  end

  def create
    @task = Task.new(task_params.merge(creator: current_user))
    authorize @task

    if @task.save
      Notification.create_for(users: @task.assignee, actor: current_user, notifiable: @task, kind: :task_assigned)
      redirect_to tasks_path(band_id: @task.band_id), notice: "Task created."
    else
      redirect_to tasks_path(band_id: @task.band_id), alert: @task.errors.full_messages.to_sentence
    end
  end

  def update
    authorize @task

    if @task.update(task_params)
      if @task.saved_change_to_assignee_id?
        Notification.create_for(users: @task.assignee, actor: current_user, notifiable: @task, kind: :task_assigned)
      end
      redirect_to tasks_path(band_id: @task.band_id), notice: "Task updated."
    else
      redirect_to tasks_path(band_id: @task.band_id), alert: @task.errors.full_messages.to_sentence
    end
  end

  def destroy
    authorize @task
    band_id = @task.band_id
    @task.destroy
    redirect_to tasks_path(band_id: band_id), notice: "Task deleted."
  end

  private

    def set_task
      @task = policy_scope(Task).find(params[:id])
    end

    def task_params
      params.require(:task).permit(:band_id, :title, :description, :status, :assignee_id)
    end
end
