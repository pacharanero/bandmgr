class CreateApiKeys < ActiveRecord::Migration[8.1]
  def change
    create_table :api_keys do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :band, foreign_key: true
      t.string :name, null: false
      t.string :token, null: false
      t.string :scopes, default: "read", null: false
      t.datetime :last_used_at
      t.datetime :expires_at
      t.datetime :revoked_at
      t.text :description

      t.index :token, unique: true
      t.index [ :user_id, :band_id ]
    end
  end
end
