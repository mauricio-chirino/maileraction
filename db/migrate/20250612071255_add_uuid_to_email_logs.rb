class AddUuidToEmailLogs < ActiveRecord::Migration[8.0]
  def up
    add_column :email_logs, :uuid, :uuid, default: "gen_random_uuid()", null: false unless column_exists?(:email_logs, :uuid)
    add_index :email_logs, :uuid, unique: true unless index_exists?(:email_logs, :uuid)
    # No backfill necesario si usas default, pero si tienes datos antiguos sin uuid, haz:
    # EmailLog.reset_column_information
    # EmailLog.where(uuid: nil).find_each { |el| el.update_column(:uuid, SecureRandom.uuid) }
  end
  def down
    remove_index :email_logs, :uuid if index_exists?(:email_logs, :uuid)
    remove_column :email_logs, :uuid if column_exists?(:email_logs, :uuid)
  end
end
