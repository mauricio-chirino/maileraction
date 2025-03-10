class CreateScrapingSources < ActiveRecord::Migration[8.0]
  def change
    create_table :scraping_sources do |t|
      t.string :url
      t.string :status

      t.timestamps
    end
  end
end
