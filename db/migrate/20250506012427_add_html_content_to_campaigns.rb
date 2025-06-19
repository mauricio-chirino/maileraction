class AddHtmlContentToCampaigns < ActiveRecord::Migration[8.0]
  def change
    add_column :campaigns, :html_content, :text
  end
end
