class AddSongSortToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :song_sort, :string, null: false, default: "title"
    add_column :users, :song_sort_direction, :string, null: false, default: "asc"
  end
end
