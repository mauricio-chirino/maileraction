class CreateScrapeTargets < ActiveRecord::Migration[8.0]
  def change
    create_table :scrape_targets do |t|
      t.string :url
      t.string :status
      t.datetime :last_attempt_at

      t.timestamps
    end
  end
end
