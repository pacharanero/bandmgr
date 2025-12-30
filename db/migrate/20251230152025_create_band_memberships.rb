class CreateBandMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :band_memberships do |t|
      t.references :band, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, null: false, default: 1

      t.timestamps
    end

    add_index :band_memberships, %i[band_id user_id], unique: true
  end
end
