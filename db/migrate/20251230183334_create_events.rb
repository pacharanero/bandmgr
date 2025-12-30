class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.references :band, null: false, foreign_key: true
      t.integer :kind, null: false, default: 0
      t.datetime :starts_at
      t.string :venue
      t.text :notes

      t.timestamps
    end
  end
end
