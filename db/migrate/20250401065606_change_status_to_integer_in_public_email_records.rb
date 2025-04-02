class ChangeStatusToIntegerInPublicEmailRecords < ActiveRecord::Migration[8.0]
  def change
    remove_column :public_email_records, :status
    add_column :public_email_records, :status, :integer, default: 0, null: false
  end
end
