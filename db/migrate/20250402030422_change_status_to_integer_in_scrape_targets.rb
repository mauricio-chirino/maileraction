class ChangeStatusToIntegerInScrapeTargets < ActiveRecord::Migration[8.0]
  def change
    change_column :scrape_targets, :status, :integer, using: 'status::integer'
  end
end
