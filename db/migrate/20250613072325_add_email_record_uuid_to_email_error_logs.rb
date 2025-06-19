class AddEmailRecordUuidToEmailErrorLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :email_error_logs, :email_record_uuid, :uuid
  end
end
