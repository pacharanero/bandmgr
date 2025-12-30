class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs do |t|
      t.references :account, null: false, foreign_key: true
      t.string :title, null: false
      t.string :artist
      t.string :album
      t.string :key
      t.integer :tempo
      t.text :notes

      t.timestamps
    end
  end
end
