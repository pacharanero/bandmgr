class AddBandToSongs < ActiveRecord::Migration[8.0]
  class MigrationBand < ApplicationRecord
    self.table_name = "bands"
  end

  class MigrationSong < ApplicationRecord
    self.table_name = "songs"
  end

  def up
    add_reference :songs, :band, foreign_key: true

    backfill_band_ids

    change_column_null :songs, :band_id, false
  end

  def down
    remove_reference :songs, :band, foreign_key: true
  end

  private
    def backfill_band_ids
      band_ids = MigrationBand.group(:account_id).minimum(:id)
      band_ids.each do |account_id, band_id|
        MigrationSong.where(account_id: account_id, band_id: nil).update_all(band_id: band_id)
      end
    end
end
