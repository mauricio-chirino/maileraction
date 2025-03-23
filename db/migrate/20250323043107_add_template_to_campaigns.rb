class AddTemplateToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_reference :campaigns, :template, foreign_key: true
  end
end
