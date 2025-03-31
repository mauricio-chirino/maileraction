class AddSourceKeywordToPublicEmailRecords < ActiveRecord::Migration[8.0]
  def change
    add_column :public_email_records, :source_keyword, :string
  end
end
