module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    MAX_ATTEMPTS = 3
    RETRY_DELAY = 30.seconds

    def perform(campaign_id)
      campaign = Campaign.find_by(id: campaign_id)
      return if campaign.nil? || campaign.status == "completed"

      email_body = campaign.body.presence || campaign.template&.content

      if campaign.subject.blank? || email_body.blank?
        campaign.update!(status: "failed")
        AdminNotifierJob.perform_later("❌ Campaña #{campaign.id} falló: sin asunto o contenido.")
        NotificationSender.call(
          user: campaign.user,
          title: "Campaña no enviada",
          body: "Tu campaña \"#{campaign.subject || 'Sin asunto'}\" no se envió porque le falta asunto o contenido."
        )
        return
      end

      recipients = EmailRecord.where(industry_id: campaign.industry_id).limit(campaign.email_limit)
      if recipients.empty?
        campaign.update!(status: "failed")
        AdminNotifierJob.perform_later("📭 Campaña #{campaign.id} no tiene destinatarios.")
        NotificationSender.call(
          user: campaign.user,
          title: "⚠️ Campaña sin destinatarios",
          body: "La campaña \"#{campaign.subject}\" no tiene destinatarios para enviar."
        )
        return
      end

      ses = Aws::SES::Client.new
      sender = Rails.application.credentials.dig(:mailer, :from_email)

      recipients.each do |recipient|
        log = EmailLog.find_or_initialize_by(campaign: campaign, email_record: recipient)

        next if log.status == "success"
        next if log.attempts_count.to_i >= MAX_ATTEMPTS

        begin
          response = ses.send_email({
            destination: { to_addresses: [ recipient.email ] },
            message: {
              body: { html: { charset: "UTF-8", data: email_body } },
              subject: { charset: "UTF-8", data: campaign.subject }
            },
            source: sender
          })

          log.update!(
            status: "success",
            attempts_count: log.attempts_count.to_i + 1
          )

          EmailEventLogger.call(
            email: recipient.email,
            campaign: campaign,
            event_type: "sent",
            metadata: { message_id: response.message_id }
          )

        rescue Aws::SES::Errors::ServiceError => e
          email_log = EmailLog.find_or_initialize_by(campaign: campaign, email_record: recipient)
          email_log.status = "error"
          email_log.attempts_count = email_log.attempts_count.to_i + 1
          email_log.save!
        
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
        
          if email_log.attempts_count >= MAX_ATTEMPTS
            if recipient.respond_to?(:increment_bounce!)
              recipient.increment_bounce!
            end
            Rails.logger.warn("📤 Correo desactivado tras #{MAX_ATTEMPTS} intentos fallidos: #{recipient.email}")
          else
            Rails.logger.info("🔁 Reintentando a #{recipient.email} (#{email_log.attempts_count}/#{MAX_ATTEMPTS})")
            SendCampaignJob.set(wait: 30.seconds).perform_later(campaign.id)
          end
        
      end

      finalize_campaign(campaign)
    end

    private

    def finalize_campaign(campaign)
      if EmailLog.where(campaign: campaign, status: "success").exists?
        sent   = EmailLog.where(campaign: campaign, status: "success").count
        errors = EmailLog.where(campaign: campaign, status: "error").count
        total  = sent + errors
        error_pct = ((errors.to_f / total) * 100).round(1)

        NotificationSender.call(
          user: campaign.user,
          title: "✅ Tu campaña fue enviada con éxito",
          body: <<~MSG.strip
            La campaña "#{campaign.subject}" fue enviada a #{total} destinatarios.
            ✅ Éxito: #{sent} | ❌ Errores: #{errors} | ⚠️ Tasa de error: #{error_pct}%
          MSG
        )
      else
        NotificationSender.call(
          user: campaign.user,
          title: "⚠️ Campaña procesada sin envíos",
          body: "La campaña \"#{campaign.subject}\" no se pudo enviar a ningún destinatario."
        )
      end

      campaign.update!(status: "completed")
    end
  end
end
