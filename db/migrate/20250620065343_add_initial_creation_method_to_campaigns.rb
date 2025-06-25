class AddInitialCreationMethodToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :initial_creation_method, :integer
  end
end
