class EncryptAccountAiApiKeys < ActiveRecord::Migration[8.1]
  def up
    add_column :accounts, :encrypted_ai_openai_api_key, :text
    add_column :accounts, :encrypted_ai_anthropic_api_key, :text

    Account.reset_column_information
    Account.find_each do |account|
      account.encrypted_ai_openai_api_key = account[:ai_openai_api_key]
      account.encrypted_ai_anthropic_api_key = account[:ai_anthropic_api_key]
      account[:ai_openai_api_key] = nil
      account[:ai_anthropic_api_key] = nil
      account.save!(validate: false)
    end
  end

  def down
    Account.reset_column_information
    Account.find_each do |account|
      account[:ai_openai_api_key] = account.encrypted_ai_openai_api_key
      account[:ai_anthropic_api_key] = account.encrypted_ai_anthropic_api_key
      account.save!(validate: false)
    end

    remove_column :accounts, :encrypted_ai_openai_api_key
    remove_column :accounts, :encrypted_ai_anthropic_api_key
  end
end
