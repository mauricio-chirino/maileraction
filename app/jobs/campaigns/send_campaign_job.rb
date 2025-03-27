module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    def perform(campaign_id)
      campaign = Campaign.find(campaign_id)
      return if campaign.status == "completed"

      email_body = campaign.body.presence || campaign.template&.content

      if campaign.subject.blank? || email_body.blank?
        campaign.update!(status: "failed")
        AdminNotifierJob.perform_later("❌ Campaña #{campaign.id} falló: sin asunto o contenido.")
        NotificationSender.call(
          user: campaign.user,
          title: "❌ Campaña no enviada",
          body: "Tu campaña \"#{campaign.subject || 'Sin asunto'}\" no se envió porque le falta asunto o contenido."
        )
        return
      end

      recipients = EmailRecord.where(industry_id: campaign.industry_id).limit(campaign.email_limit)

      if recipients.empty?
        campaign.update!(status: "failed")
        AdminNotifierJob.perform_later("📭 Campaña #{campaign.id} no tiene destinatarios y no fue enviada.")
        NotificationSender.call(
          user: campaign.user,
          title: "⚠️ Campaña procesada sin envíos",
          body: "La campaña \"#{campaign.subject}\" fue procesada, pero no se registraron intentos de envío."
        )
        return
      end

      ses = Aws::SES::Client.new
      sender = Rails.application.credentials.dig(:mailer, :from_email)

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

          Rails.logger.error("❌ Error al enviar a #{recipient.email}: #{e.message}")
        end
      end

      if EmailLog.where(status: "error").where("created_at >= ?", 5.minutes.ago).count >= 3
        AdminNotifierJob.perform_later("🚨 Se detectaron múltiples errores en el envío de campañas.")
        NotificationSender.call(
          user: campaign.user,
          title: "🚨 Problemas en la campaña",
          body: "Se detectaron múltiples errores al enviar tu campaña \"#{campaign.subject}\". Verifica el contenido o contacta soporte."
        )
      end

      campaign.update!(status: "completed")

      sent   = EmailLog.where(campaign: campaign, status: "success").count
      errors = EmailLog.where(campaign: campaign, status: "error").count
      total  = sent + errors

      if total.zero?
        # No se envió a nadie
        NotificationSender.call(
          user: campaign.user,
          title: "⚠️ Campaña procesada sin envíos",
          body: "La campaña \"#{campaign.subject}\" fue procesada, pero no se registraron intentos de envío."
        )
      else
        error_pct = ((errors.to_f / total) * 100).round(1)
        NotificationSender.call(
          user: campaign.user,
          title: "✅ Tu campaña fue enviada con éxito",
          body: <<~MSG.strip
            La campaña "#{campaign.subject}" fue enviada a #{total} destinatarios.
            ✅ Éxito: #{sent} | ❌ Errores: #{errors} | ⚠️ Tasa de error: #{error_pct}%
          MSG
        )
      end
    end
  end
end
