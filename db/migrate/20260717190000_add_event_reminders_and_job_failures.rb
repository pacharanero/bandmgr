class AddEventRemindersAndJobFailures < ActiveRecord::Migration[8.1]
  def change
    add_column :events, :reminder_sent_at, :datetime

    create_table :job_failures do |t|
      t.string :job_class, null: false
      t.string :active_job_id, null: false
      t.string :error_class, null: false
      t.text :message, null: false
      t.datetime :occurred_at, null: false
      t.timestamps
    end
    add_index :job_failures, :active_job_id
    add_index :job_failures, :occurred_at
  end
end
