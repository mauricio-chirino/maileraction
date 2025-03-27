module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    def perform(campaign_id)
      campaign = Campaign.find(campaign_id)
      return if campaign.status == "completed"

      email_body = campaign.body.presence || campaign.template&.content

      if campaign.subject.blank? || email_body.blank?
        Rails.logger.warn("⚠️ Campaña #{campaign.id} sin asunto o contenido. No se envió.")
        campaign.update!(status: "failed")

        AdminNotifierJob.perform_later("❌ Campaña #{campaign.id} falló: sin asunto o contenido.")
        return
      end

      recipients = EmailRecord.where(industry_id: campaign.industry_id)
                              .limit(campaign.email_limit)



      if campaign.user.usuario_prepago?
        credits_available = campaign.user.credit_account&.credits.to_i
        if recipients.size > credits_available
          Rails.logger.warn("❌ Usuario #{campaign.user.id} sin créditos suficientes para enviar la campaña.")
          campaign.update!(status: "failed")
          AdminNotifierJob.perform_later("❌ Usuario #{campaign.user.email_address} intentó enviar una campaña sin créditos suficientes.")
          Notification.create!(
            user: campaign.user,
            title: "❌ No tienes créditos suficientes",
            body: "Intentaste enviar tu campaña a #{recipients.size} destinatarios, pero solo tienes #{credits_available} créditos disponibles."
          )
          return
        end
      end






      if recipients.empty?
        Rails.logger.warn("⚠️ Campaña #{campaign.id} no tiene destinatarios. No se envió.")
        campaign.update!(status: "failed")
        AdminNotifierJob.perform_later("📭 Campaña #{campaign.id} no tiene destinatarios y no fue enviada.")
        return
      end

      # 🧮 Verificar créditos (solo para usuarios prepagos)
      if campaign.user.role == "usuario_prepago"
        credit_account = campaign.user.credit_account
        if credit_account.nil? || credit_account.credits < recipients.count
          Rails.logger.warn("❌ Usuario sin créditos suficientes para campaña #{campaign.id}")
          campaign.update!(status: "failed")

          Notification.create!(
            user: campaign.user,
            title: "⚠️ Campaña no enviada",
            body: "No tenés créditos suficientes para enviar esta campaña. Créditos requeridos: #{recipients.count}."
          )
          return
        end

        # Descontar créditos
        CreditAccount.transaction do
          credit_account.update!(credits: credit_account.credits - recipients.count)

          campaign.transaction do
            recipients.each do |recipient|
              Transaction.create!(
                credit_account: credit_account,
                amount: -1,
                reason: "Envío de email a #{recipient.email}",
                campaign: campaign
              )
            end
          end
        end
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



          # ✅ Descontar 1 crédito si es usuario prepago
          if campaign.user.usuario_prepago?
            account = campaign.user.credit_account
            account.update!(credits: account.credits - 1)
          end



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

      sent   = EmailLog.where(campaign: campaign, status: "success").count
      errors = EmailLog.where(campaign: campaign, status: "error").count
      total  = sent + errors

      if total.zero?
        Notification.create!(
          user: campaign.user,
          title: "⚠️ Campaña procesada sin envíos",
          body: "La campaña \"#{campaign.subject}\" fue procesada, pero no se registraron intentos de envío.",
        )
      else
        error_pct = ((errors.to_f / total) * 100).round(1)

        notification = Notification.create!(
          user: campaign.user,
          title: "✅ Tu campaña fue enviada con éxito",
          body: <<~MSG.strip
            La campaña "#{campaign.subject}" fue enviada a #{total} destinatarios.
            ✅ Éxito: #{sent} | ❌ Errores: #{errors} | ⚠️ Tasa de error: #{error_pct}%
          MSG
        )

        Notifications::SendEmailJob.perform_later(notification.id)
      end
    end
  end
end
