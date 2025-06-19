class AddUuidToScrapingSources < ActiveRecord::Migration[8.0]
  def change
    add_column :scraping_sources, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false
    add_index :scraping_sources, :uuid, unique: true
  end
end
