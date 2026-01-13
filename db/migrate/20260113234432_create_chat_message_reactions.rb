class CreateChatMessageReactions < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_message_reactions do |t|
      t.references :chat_message, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :kind, null: false, default: "like"
      t.timestamps
    end

    add_index :chat_message_reactions, %i[chat_message_id user_id kind], unique: true, name: "index_chat_message_reactions_unique"
  end
end
