class AddBandAndSongMetadata < ActiveRecord::Migration[8.0]
  def change
    change_table :songs, bulk: true do |t|
      t.string :chart_url
      t.string :original_artist
      t.string :video_url
    end

    change_table :bands, bulk: true do |t|
      t.string :location
      t.string :phone
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :youtube
      t.string :bandcamp
      t.string :soundcloud
    end

    add_column :tags, :color, :string, default: "blue", null: false
  end
end
