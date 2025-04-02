class AddStatusToPublicEmailRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :public_email_records, :status, :string, default: "pending", null: false
  end
end
