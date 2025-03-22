# app/jobs/campaigns/send_campaign_job.rb
module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    def perform(campaign_id)
      campaign = Campaign.find(campaign_id)
      return if campaign.status == "sent"

      recipients = EmailRecord.where(industry_id: campaign.industry_id)
                              .limit(campaign.email_limit)

      ses = Aws::SES::Client.new
      sender = ENV["SES_VERIFIED_SENDER"] || "info@maileraction.com"

      recipients.each do |recipient|
        begin
          response = ses.send_email({
            destination: {
              to_addresses: [ recipient.email ]
            },
            message: {
              body: {
                html: {
                  charset: "UTF-8",
                  data: campaign.body
                }
              },
              subject: {
                charset: "UTF-8",
                data: campaign.subject
              }
            },
            source: sender
          })

          Rails.logger.info("✅ Email enviado a #{recipient.email}, ID: #{response.message_id}")

        rescue Aws::SES::Errors::ServiceError => e
          Rails.logger.error("❌ Error al enviar a #{recipient.email}: #{e.message}")
        end
      end

      campaign.update!(status: "sent")
    end
  end
end
