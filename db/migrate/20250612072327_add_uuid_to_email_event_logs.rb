class AddUuidToEmailEventLogs < ActiveRecord::Migration[8.0]
  def up
    add_column :email_event_logs, :uuid, :uuid, default: "gen_random_uuid()", null: false unless column_exists?(:email_event_logs, :uuid)
    add_index :email_event_logs, :uuid, unique: true unless index_exists?(:email_event_logs, :uuid)
    # EmailEventLog.reset_column_information
    # EmailEventLog.where(uuid: nil).find_each { |eel| eel.update_column(:uuid, SecureRandom.uuid) }
  end
  def down
    remove_index :email_event_logs, :uuid if index_exists?(:email_event_logs, :uuid)
    remove_column :email_event_logs, :uuid if column_exists?(:email_event_logs, :uuid)
  end
end
