require "test_helper"

class Api::V1::TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @band = bands(:one)
    @task = Task.create!(band: @band, creator: @user, title: "Test Task", status: "todo")
    @api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "all")
  end

  test "lists tasks" do
    get api_v1_tasks_path, headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_includes response.parsed_body.pluck("id"), @task.id
  end

  test "shows a task" do
    get api_v1_task_path(@task), headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal @task.title, response.parsed_body["title"]
  end

  test "creates a task" do
    assert_difference("Task.count", 1) do
      post api_v1_tasks_path, params: { task: { band_id: @band.id, title: "New Task" } },
        headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :created
  end

  test "updates a task" do
    @api_key.update!(scopes: "read,write")

    patch api_v1_task_path(@task), params: { task: { title: "Updated" } },
      headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal "Updated", @task.reload.title
  end

  test "destroys a task" do
    @api_key.update!(scopes: "all")

    assert_difference("Task.count", -1) do
      delete api_v1_task_path(@task), headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :no_content
  end
end
