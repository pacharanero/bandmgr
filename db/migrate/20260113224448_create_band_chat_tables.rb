class CreateBandChatTables < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_channels do |t|
      t.references :band, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :kind, null: false, default: 0
      t.timestamps
    end

    create_table :chat_channel_participants do |t|
      t.references :chat_channel, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :chat_channel_participants, %i[chat_channel_id user_id], unique: true, name: "index_chat_channel_participants_unique"

    create_table :chat_messages do |t|
      t.references :chat_channel, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :body, null: false
      t.bigint :parent_id
      t.timestamps
    end
    add_index :chat_messages, :parent_id
    add_foreign_key :chat_messages, :chat_messages, column: :parent_id
  end
end
