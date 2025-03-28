# app/services/campaigns/campaign_email_sender.rb
module Campaigns
  class CampaignEmailSender
    def self.call(campaign:, recipient:)
      ses = Aws::SES::Client.new
      sender = Rails.application.credentials.dig(:mailer, :from_email)
      email_body = campaign.body.presence || campaign.template&.content

      raise "Falta asunto o contenido" if campaign.subject.blank? || email_body.blank?

      response = ses.send_email({
        destination: { to_addresses: [ recipient.email ] },
        message: {
          body: { html: { charset: "UTF-8", data: email_body } },
          subject: { charset: "UTF-8", data: campaign.subject }
        },
        source: sender
      })

      EmailLog.create!(
        campaign: campaign,
        email_record: recipient,
        status: "success"
      )

      EmailEventLogger.call(
        email: recipient.email,
        campaign: campaign,
        event_type: "sent",
        metadata: { message_id: response.message_id }
      )
    rescue => e
      EmailLog.create!(
        campaign: campaign,
        email_record: recipient,
        status: "error"
      )

      EmailErrorLog.create!(
        email: recipient.email,
        campaign_id: campaign.id,
        error: e.message
      )

      EmailEventLogger.call(
        email: recipient.email,
        campaign: campaign,
        event_type: "error",
        metadata: { error_message: e.message }
      )

      raise e
    end
  end
end
