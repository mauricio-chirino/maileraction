class AddCanvasClearedToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :canvas_cleared, :boolean
  end
end
