class CreateCollaborationTables < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :band, null: false, foreign_key: true
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :assignee, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :tasks, %i[band_id status]

    create_table :comments do |t|
      t.references :band, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :commentable, null: false, polymorphic: true
      t.text :body, null: false
      t.timestamps
    end

    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :actor, foreign_key: { to_table: :users }
      t.references :notifiable, null: false, polymorphic: true
      t.integer :kind, null: false, default: 0
      t.datetime :read_at
      t.timestamps
    end
    add_index :notifications, %i[user_id read_at]
  end
end
