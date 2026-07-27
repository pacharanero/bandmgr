require "test_helper"

class Api::V1::SetlistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @band = bands(:one)
    @setlist = Setlist.create!(band: @band, title: "Test Setlist")
    @api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "all")
  end

  test "lists setlists" do
    get api_v1_setlists_path, headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_includes response.parsed_body.pluck("id"), @setlist.id
  end

  test "shows a setlist" do
    get api_v1_setlist_path(@setlist), headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal @setlist.title, response.parsed_body["title"]
  end

  test "creates a setlist" do
    assert_difference("Setlist.count", 1) do
      post api_v1_setlists_path, params: { setlist: { title: "New Setlist", band_id: @band.id } },
        headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :created
  end

  test "updates a setlist" do
    @api_key.update!(scopes: "read,write")

    patch api_v1_setlist_path(@setlist), params: { setlist: { title: "Updated" } },
      headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal "Updated", @setlist.reload.title
  end

  test "destroys a setlist" do
    @api_key.update!(scopes: "all")

    assert_difference("Setlist.count", -1) do
      delete api_v1_setlist_path(@setlist), headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :no_content
  end
end
