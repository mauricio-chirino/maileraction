class AddBouncesCountAndActiveToEmailRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :email_records, :bounces_count, :integer
    add_column :email_records, :active, :boolean
  end
end
