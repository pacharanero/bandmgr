require "test_helper"

class SetlistSongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setlist = Setlist.create!(account: accounts(:one), band: bands(:one), title: "Reorder test")
    @first = @setlist.setlist_songs.create!(song: songs(:one), position: 1)
    @second_song = Song.create!(account: accounts(:one), band: bands(:one), title: "Second song")
    @second = @setlist.setlist_songs.create!(song: @second_song, position: 2)
  end

  test "moves a setlist song with a non-drag control" do
    sign_in_as users(:one)

    patch move_setlist_setlist_song_path(@setlist, @second, direction: "up")

    assert_redirected_to @setlist
    assert_equal [ @second.id, @first.id ], @setlist.setlist_songs.order(:position).pluck(:id)
  end
end
