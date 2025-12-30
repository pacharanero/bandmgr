class CreateBands < ActiveRecord::Migration[8.0]
  def change
    create_table :bands do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
