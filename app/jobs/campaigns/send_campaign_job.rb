# app/jobs/campaigns/send_campaign_job.rb
module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    def perform(campaign_id)
      campaign = Campaign.find(campaign_id)
      return if campaign.status == "completed"

      if campaign.subject.blank? || campaign.body.blank?
        Rails.logger.warn("⚠️ Campaña #{campaign.id} sin asunto o contenido. No se envió.")
        return
      end

      recipients = EmailRecord.where(industry_id: campaign.industry_id)
                              .limit(campaign.email_limit)

      ses = Aws::SES::Client.new
      sender = ENV["SES_VERIFIED_SENDER"] || "info@maileraction.com"

      recipients.each do |recipient|
        begin
          response = ses.send_email({
            destination: { to_addresses: [ recipient.email ] },
            message: {
              body: {
                html: { charset: "UTF-8", data: campaign.body }
              },
              subject: {
                charset: "UTF-8", data: campaign.subject
              }
            },
            source: sender
          })

          # Guardar en EmailLog
          EmailLog.create!(
            campaign: campaign,
            email_record: recipient,
            status: "success"
          )

          Rails.logger.info("✅ Email enviado a #{recipient.email}, ID: #{response.message_id}")

        rescue Aws::SES::Errors::ServiceError => e
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

          Rails.logger.error("❌ Error al enviar a #{recipient.email}: #{e.message}")
        end
      end

      # Notificar al admin si hubo 3 o más errores en los últimos 5 minutos
      if EmailLog.where(status: "error").where("created_at >= ?", 5.minutes.ago).count >= 3
        AdminNotifierJob.perform_later("🚨 Se detectaron múltiples errores en el envío de campañas.")
      end

      campaign.update!(status: "completed")
    end
  end
end
