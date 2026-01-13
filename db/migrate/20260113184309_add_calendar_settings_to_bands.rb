class AddCalendarSettingsToBands < ActiveRecord::Migration[8.0]
  def change
    change_table :bands, bulk: true do |t|
      t.string :private_calendar_token
      t.string :public_calendar_token
      t.boolean :public_calendar_enabled, default: false, null: false
      t.boolean :public_calendar_include_rehearsals, default: false, null: false
    end

    add_index :bands, :private_calendar_token, unique: true
    add_index :bands, :public_calendar_token, unique: true
  end
end
