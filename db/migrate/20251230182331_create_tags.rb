class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end

    add_index :tags, %i[account_id name], unique: true
  end
end
