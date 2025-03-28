class EmailRetryJob < ApplicationJob
  queue_as :default

  MAX_ATTEMPTS = 3
  RETRY_WAIT   = 5.minutes

  def perform
    failed_logs = EmailLog
                    .where(status: "error")
                    .where("attempts_count < ?", MAX_ATTEMPTS)
                    .where("updated_at < ?", RETRY_WAIT.ago)

    failed_logs.each do |log|
      SendCampaignJob.perform_later(log.campaign_id)
    end
  end
end
