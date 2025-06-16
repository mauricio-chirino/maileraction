class AddUuidToScrapeTargets < ActiveRecord::Migration[8.0]
  def change
    add_column :scrape_targets, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false
    add_index :scrape_targets, :uuid, unique: true
  end
end
