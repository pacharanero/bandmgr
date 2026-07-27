require "test_helper"

class Api::V1::BandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @band = bands(:one)
    @api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "all")
  end

  test "lists bands for authenticated user" do
    get api_v1_bands_path, headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal [ @band.id ], response.parsed_body.pluck("id")
  end

  test "shows a band" do
    get api_v1_band_path(@band), headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal @band.name, response.parsed_body["name"]
  end

  test "creates a band" do
    assert_difference("Band.count", 1) do
      post api_v1_bands_path, params: { band: { name: "New Band", description: "Test" } },
        headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :created
  end

  test "updates a band with write permission" do
    @api_key.update!(scopes: "read,write")

    patch api_v1_band_path(@band), params: { band: { name: "Updated Name" } },
      headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal "Updated Name", @band.reload.name
  end

  test "rejects update without write permission" do
    @api_key.update!(scopes: "read")

    patch api_v1_band_path(@band), params: { band: { name: "Updated Name" } },
      headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :forbidden
  end

  test "destroys a band with delete permission" do
    @api_key.update!(scopes: "all")

    assert_difference("Band.count", -1) do
      delete api_v1_band_path(@band), headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :no_content
  end

  test "rejects request without token" do
    get api_v1_bands_path

    assert_response :unauthorized
  end

  test "rejects request with invalid token" do
    get api_v1_bands_path, headers: { "Authorization" => "Bearer invalid-token" }

    assert_response :unauthorized
  end
end
