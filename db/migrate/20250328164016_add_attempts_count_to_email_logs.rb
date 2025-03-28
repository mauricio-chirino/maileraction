class AddAttemptsCountToEmailLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :email_logs, :attempts_count, :integer
  end
end
