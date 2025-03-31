class ScrapeEmailJob < ApplicationJob
  queue_as :default

  def perform(url)
    PublicEmailScraperService.new(url).scrape_and_save
  end
end
