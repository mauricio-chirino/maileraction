module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    def perform(campaign_id)
      campaign = Campaign.find(campaign_id)
      return if campaign.status == "sent"

      # Aquí deberías obtener los destinatarios
      recipients = EmailRecord.where(industry_id: campaign.industry_id).limit(campaign.email_limit)

      recipients.each do |recipient|
        # Aquí podrías enviar el email con AWS SES, por ahora solo simular
        EmailLog.create!(
          campaign: campaign,
          email_record: recipient,
          status: "sent"
        )
      end

      campaign.update(status: "sent")
    end
  end
end
