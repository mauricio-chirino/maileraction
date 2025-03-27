module Api
  module V1
    class WebhooksController < ActionController::API
      # Este controlador es seguro para recibir llamadas externas
      # skip_before_action :verify_authenticity_token, only: [ :aws_ses_tracking ]

      def payment
        # Aquí irá la lógica para procesar pagos y recargar créditos
        # según el servicio de Stripe / MercadoPago
        head :ok
      end




      def aws_ses
        raw = request.raw_post
        Rails.logger.info("Raw POST recibido: #{raw}")

        payload = JSON.parse(raw)
        Rails.logger.info("Payload parseado: #{payload.inspect}")

        if payload["notificationType"] == "Bounce"
          bounced = payload.dig("bounce", "bouncedRecipients")
          campaign_id = payload.dig("mail", "tags", "campaign_id")&.first
          Rails.logger.info("campaign_id: #{campaign_id}, bounced: #{bounced}")

          if bounced && campaign_id
            bounced.each do |recipient|
              email = recipient["emailAddress"]
              Rails.logger.info("Procesando rebote para: #{email}")

              ReboundCreditRefunder.call(campaign_id: campaign_id, email: email)
            end
          else
            Rails.logger.warn("Rebote recibido sin campaign_id o sin destinatarios.")
          end
        end

        render json: { status: "ok" }, status: :ok
        rescue JSON::ParserError => e
          Rails.logger.error("Error JSON: #{e.message}")
          Rails.logger.error(e.backtrace.join("\n"))
          render json: { error: "Invalid JSON" }, status: :bad_request
        rescue => e
          Rails.logger.error("Error al procesar webhook SES: #{e.message}")
          Rails.logger.error(e.backtrace.join("\n"))
          render json: { error: "Error interno" }, status: :internal_server_error
      end



      def aws_ses_tracking
        payload = JSON.parse(request.raw_post)
        Rails.logger.info("AWS SES Tracking payload recibido: #{payload}")

        mail_data = payload["mail"]
        event_type = payload["eventType"]
        campaign_id = mail_data.dig("tags", "campaign_id")&.first
        recipient = mail_data["destination"]&.first

        if campaign_id && recipient
          TrackEmailEvent.call(
            campaign_id: campaign_id,
            email: recipient,
            event_type: event_type
          )
        end

        head :ok # Responder con 200 OK
      rescue => e
        Rails.logger.error("Error procesando webhook SES Tracking: #{e.message}")
        render json: { error: "invalid payload" }, status: :unprocessable_entity
      end
    end
  end
end
