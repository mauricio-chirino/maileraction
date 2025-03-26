module Campaigns
  class SendCampaignJob < ApplicationJob
    queue_as :default

    # Executes the process of sending a campaign email to a list of recipients.
    #
    # @param campaign_id [Integer] The ID of the campaign to be processed.
    #
    # The method performs the following steps:
    # 1. Fetches the campaign by its ID and skips processing if the campaign's status is "completed".
    # 2. Determines the email body using the campaign's body or its associated template content.
    # 3. Logs a warning and marks the campaign as "failed" if the subject or email body is blank.
    # 4. Retrieves a list of recipients based on the campaign's industry and email limit.
    # 5. Logs a warning and marks the campaign as "failed" if no recipients are found.
    # 6. Sends emails to the recipients using AWS SES, logging successes and errors.
    # 7. Tracks errors and notifies an admin if multiple errors occur within a short time frame.
    # 8. Updates the campaign's status to "completed" after processing.
    # 9. Creates a notification for the user with a summary of the campaign's results.
    # 10. Optionally sends an email notification to the user about the campaign's completion.
    #
    #
    #
    # Sends a campaign email to a list of recipients and handles logging, error tracking,
    # and notifications for the campaign's progress and results.
    #
    # Notifications:
    # - Creates a notification for the campaign's user summarizing the results of the email campaign.
    # - The notification includes the total number of recipients, the number of successful emails,
    #   the number of errors, and the error rate percentage.
    # - Optionally triggers an email to the user with the campaign results.
    #
    # Parameters:
    # - campaign_id: The ID of the campaign to be processed.
    #
    # Behavior:
    # - If the campaign is already completed, it exits early.
    # - If the campaign lacks a subject or content, it marks the campaign as failed and notifies the admin.
    # - If there are no recipients, it marks the campaign as failed and notifies the admin.
    # - Sends emails to recipients using AWS SES, logs successes and errors, and tracks error details.
    # - If multiple errors are detected within a short time frame, it notifies the admin.
    # - Updates the campaign status to "completed" after processing all recipients.
    #


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
      sender = Rails.application.credentials.dig(:mailer, :from_email)

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

      sent      = EmailLog.where(campaign: campaign, status: "success").count
      errors    = EmailLog.where(campaign: campaign, status: "error").count
      total     = sent + errors

      if total.zero?
        Notification.create!(
          user: campaign.user,
          title: "⚠️ Campaña procesada sin envíos",
          body: "La campaña \"#{campaign.subject}\" fue procesada, pero no se registraron intentos de envío.",
        )
      else
        error_pct = ((errors.to_f / total) * 100).round(1)

        Notification.create!(
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
