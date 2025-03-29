module Campaigns
  class SendCampaignBatchJob < ApplicationJob
    queue_as :default

    MAX_ATTEMPTS = 3
    BATCH_SIZE = 100

    def perform(campaign_id, offset = 0)
      campaign = Campaign.find_by(id: campaign_id)
      return unless campaign && campaign.status != "completed"

      email_body = campaign.body.presence || campaign.template&.content
      sender = Rails.application.credentials.dig(:mailer, :from_email)
      ses = Aws::SES::Client.new

      recipients = EmailRecord.where(industry_id: campaign.industry_id)
                              .offset(offset)
                              .limit(BATCH_SIZE)

      return if recipients.empty?

      recipients.each do |recipient|
        begin
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

          EmailEventLogger.call(
            email: recipient.email,
            campaign: campaign,
            event_type: "error",
            metadata: { error_message: e.message }
          )

          recipient.increment_bounce! if recipient.respond_to?(:increment_bounce!)

          Rails.logger.error("❌ Error al enviar a #{recipient.email}: #{e.message}")
        end
      end

      # 🔔 Notificación progresiva
      total_logs   = EmailLog.where(campaign_id: campaign.id)
      success      = total_logs.where(status: "success").count
      errors       = total_logs.where(status: "error").count
      total_sent   = success + errors
      error_pct    = total_sent.zero? ? 0 : ((errors.to_f / total_sent) * 100).round(1)

      NotificationSender.call(
        user: campaign.user,
        title: "📬 Progreso de tu campaña",
        body: <<~MSG.strip
          Tu campaña "#{campaign.subject}" sigue en proceso:
          Enviados: #{total_sent}
          ✅ Éxito: #{success} | ❌ Fallos: #{errors} (Tasa error: #{error_pct}%)
        MSG
      )

      # 📦 Siguiente lote o cierre
      if recipients.size == BATCH_SIZE
        self.class.set(wait: 1.minute).perform_later(campaign_id, offset + BATCH_SIZE)
      else
        # Marcar como completada si es el último lote
        campaign.update!(status: "completed")
        Rails.logger.info("✅ Campaña #{campaign.id} completada.")

        sent   = EmailLog.where(campaign: campaign, status: "success").count
        errors = EmailLog.where(campaign: campaign, status: "error").count
        total  = sent + errors
        error_pct = ((errors.to_f / total) * 100).round(1)

        NotificationSender.call(
          user: campaign.user,
          title: "📬 Tu campaña finalizó",
          body: <<~BODY.strip
            La campaña "#{campaign.subject}" ha terminado.
            Enviados: #{total}
            ✅ Éxito: #{sent} | ❌ Fallos: #{errors} (Tasa error: #{error_pct}%)
          BODY
        )
      end
    end
  end
end
