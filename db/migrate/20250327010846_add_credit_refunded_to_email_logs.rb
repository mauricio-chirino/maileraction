class AddCreditRefundedToEmailLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :email_logs, :credit_refunded, :boolean, default: false
  end
end
