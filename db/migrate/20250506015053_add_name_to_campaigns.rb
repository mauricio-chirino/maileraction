class AddNameToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :name, :string
  end
end
