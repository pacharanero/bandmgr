require "test_helper"

class Api::V1::SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @band = bands(:one)
    @song = songs(:one)
    @api_key = ApiKey.create!(user: @user, name: "Test Key", scopes: "all")
  end

  test "lists songs" do
    get api_v1_songs_path, headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_includes response.parsed_body.pluck("id"), @song.id
  end

  test "shows a song" do
    get api_v1_song_path(@song), headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal @song.title, response.parsed_body["title"]
  end

  test "creates a song" do
    assert_difference("Song.count", 1) do
      post api_v1_songs_path, params: { song: { title: "New Song", band_id: @band.id } },
        headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :created
  end

  test "updates a song" do
    @api_key.update!(scopes: "read,write")

    patch api_v1_song_path(@song), params: { song: { title: "Updated" } },
      headers: { "Authorization" => "Bearer #{@api_key.token}" }

    assert_response :success
    assert_equal "Updated", @song.reload.title
  end

  test "destroys a song" do
    @api_key.update!(scopes: "all")

    assert_difference("Song.count", -1) do
      delete api_v1_song_path(@song), headers: { "Authorization" => "Bearer #{@api_key.token}" }
    end

    assert_response :no_content
  end
end
