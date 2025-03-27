class CreateEmailEventLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :email_event_logs do |t|
      t.string :email, null: false
      t.string :event_type, null: false # e.g. bounce, click, open
      t.jsonb :metadata, default: {}
      t.references :campaign, null: true, foreign_key: true

      t.timestamps
    end

    add_index :email_event_logs, :email
    add_index :email_event_logs, :event_type
  end
end
