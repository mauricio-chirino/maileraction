class ReplaceEnumColumnsWithInteger < ActiveRecord::Migration[8.0]
  def change
    remove_column :support_requests, :category, :string
    remove_column :support_requests, :status, :string
    remove_column :support_requests, :priority, :string
    remove_column :support_requests, :source, :string

    rename_column :support_requests, :category_int, :category
    rename_column :support_requests, :status_int, :status
    rename_column :support_requests, :priority_int, :priority
    rename_column :support_requests, :source_int, :source
  end
end
