class AddDurationAndSingerToSongs < ActiveRecord::Migration[8.0]
  def change
    change_table :songs, bulk: true do |t|
      t.integer :duration_seconds
      t.string :singer_name
      t.references :singer_band_membership, foreign_key: { to_table: :band_memberships }
    end
  end
end
