class RemoveIndustryFromPublicEmailRecords < ActiveRecord::Migration[8.0]
  def change
    remove_column :public_email_records, :industry, :string
  end
end
