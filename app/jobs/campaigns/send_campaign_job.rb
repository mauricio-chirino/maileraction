module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    def perform(campaign_id)
      campaign = Campaign.find(campaign_id)
      return if campaign.status == "completed"

      # 🧠 Usar el contenido de la plantilla si body está vacío
      email_body = campaign.body.presence || campaign.template&.content

      if campaign.subject.blank? || email_body.blank?
        Rails.logger.warn("⚠️ Campaña #{campaign.id} sin asunto o contenido. No se envió.")
        campaign.update!(status: "failed")

        AdminNotifierJob.perform_later("❌ Campaña #{campaign.id} falló: sin asunto o contenido.")
        return
      end



      recipients = EmailRecord.where(industry_id: campaign.industry_id)
                              .limit(campaign.email_limit)


      if recipients.empty?
        Rails.logger.warn("⚠️ Campaña #{campaign.id} no tiene destinatarios. No se envió.")
        campaign.update!(status: "failed")
        AdminNotifierJob.perform_later("📭 Campaña #{campaign.id} no tiene destinatarios y no fue enviada.")
        return
      end



      ses = Aws::SES::Client.new
      sender = ENV["SES_VERIFIED_SENDER"] || "info@maileraction.com"

      recipients.each do |recipient|
        begin
          response = ses.send_email({
            destination: { to_addresses: [ recipient.email ] },
            message: {
              body: {
                html: { charset: "UTF-8", data: email_body }
              },
              subject: {
                charset: "UTF-8", data: campaign.subject
              }
            },
            source: sender
          })

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

      if EmailLog.where(status: "error").where("created_at >= ?", 5.minutes.ago).count >= 3
        AdminNotifierJob.perform_later("🚨 Se detectaron múltiples errores en el envío de campañas.")
      end

      campaign.update!(status: "completed")
    end
  end
end
