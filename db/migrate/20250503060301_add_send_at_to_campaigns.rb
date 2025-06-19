class AddSendAtToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :send_at, :datetime
  end
end
