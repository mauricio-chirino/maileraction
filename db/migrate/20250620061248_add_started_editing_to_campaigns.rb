class AddStartedEditingToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :started_editing, :boolean
  end
end
