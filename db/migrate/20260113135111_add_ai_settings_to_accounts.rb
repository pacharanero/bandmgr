class AddAiSettingsToAccounts < ActiveRecord::Migration[8.0]
  def change
    change_table :accounts, bulk: true do |t|
      t.string :ai_provider
      t.string :ai_openai_api_key
      t.string :ai_anthropic_api_key
      t.string :ai_local_url
    end
  end
end
