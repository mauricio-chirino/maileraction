class AddCompanyAndNameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :company, :string
    add_column :users, :name, :string
  end
end
