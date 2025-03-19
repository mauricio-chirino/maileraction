class AddCampaignIdToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_reference :transactions, :campaign, foreign_key: true
  end
end
