class CreateSetlistsAndLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :setlists do |t|
      t.references :account, null: false, foreign_key: true
      t.references :band, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.timestamps
    end

    create_table :setlist_songs do |t|
      t.references :setlist, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
      t.integer :position, null: false, default: 0
      t.timestamps
    end
    add_index :setlist_songs, [ :setlist_id, :position ]
    add_index :setlist_songs, [ :setlist_id, :song_id ]

    create_table :event_setlists do |t|
      t.references :event, null: false, foreign_key: true
      t.references :setlist, null: false, foreign_key: true
      t.timestamps
    end
    add_index :event_setlists, [ :event_id, :setlist_id ], unique: true
  end
end
