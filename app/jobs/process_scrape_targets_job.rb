class ProcessScrapeTargetsJob < ApplicationJob
  queue_as :default

  def perform
    ScrapeTarget.status_pending.limit(10).each do |target|
      begin
        PublicEmailScraperService.new(target.url).scrape_and_save
        target.update(status: :done, last_attempt_at: Time.current)
      rescue => e
        target.update(status: :failed, last_attempt_at: Time.current)
        Rails.logger.error "❌ Falló scrapeo de #{target.url}: #{e.message}"
      end
    end
  end
end
