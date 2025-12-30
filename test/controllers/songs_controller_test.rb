require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  test "requires authentication" do
    get songs_path
    assert_redirected_to new_session_path
  end

  test "shows index for account member" do
    sign_in_as users(:one)

    get songs_path
    assert_response :success
  end

  test "filters songs by tag" do
    sign_in_as users(:one)

    get songs_path, params: { tag: tags(:one).name }
    assert_response :success
    assert_select "a", text: "Example Song"
  end

  test "persists song sort preferences" do
    sign_in_as users(:one)

    get songs_path, params: { sort: "artist", direction: "desc" }
    assert_response :success
    assert_equal "artist", users(:one).reload.song_sort
    assert_equal "desc", users(:one).song_sort_direction
  end

  test "creates a song with tags" do
    sign_in_as users(:one)

    assert_difference("Song.count", 1) do
      assert_difference("Tag.count", 1) do
        post songs_path, params: {
          song: {
            title: "New Song",
            artist: "New Artist",
            tag_list: "newtag, rehearsal"
          }
        }
      end
    end

    song = Song.order(:created_at).last
    assert_includes song.tags.pluck(:name), "newtag"
  end

  test "updates a song" do
    sign_in_as users(:one)

    patch song_path(songs(:one)), params: {
      song: {
        title: "Updated Song",
        tag_list: "fresh"
      }
    }

    assert_redirected_to song_path(songs(:one))
    assert_equal "Updated Song", songs(:one).reload.title
    assert_equal ["fresh"], songs(:one).tags.pluck(:name)
  end

  test "deletes a song" do
    sign_in_as users(:one)

    assert_difference("Song.count", -1) do
      delete song_path(songs(:one))
    end

    assert_redirected_to songs_path
  end
end
