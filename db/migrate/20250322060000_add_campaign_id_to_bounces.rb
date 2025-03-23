class AddCampaignIdToBounces < ActiveRecord::Migration[8.0]
  def change
    add_reference :bounces, :campaign, foreign_key: true
  end
end
