require "test_helper"

class ServiceWorkersControllerTest < ActionDispatch::IntegrationTest
  test "serves the root service worker without authentication" do
    get service_worker_path

    assert_response :success
    assert_equal "no-cache", response.headers.fetch("Cache-Control")
    assert_match(/addEventListener\("push"/, response.body)
  end
end
