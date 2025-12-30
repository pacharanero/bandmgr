class CreateMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :memberships do |t|
      t.references :account, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role, null: false, default: 2

      t.timestamps
    end

    add_index :memberships, %i[account_id user_id], unique: true
  end
end
