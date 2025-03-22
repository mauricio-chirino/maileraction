class AdminNotifierJob < ApplicationJob
  queue_as :default

  def perform(message)
    admin_emails = User.where(role: "admin").pluck(:email_address) # Ajustar según la lógica de roles
    return if admin_emails.empty?

    ses = Aws::SES::Client.new
    sender = ENV["SES_VERIFIED_SENDER"] || "info@maileraction.com"

    admin_emails.each do |email|
      begin
        ses.send_email({
          destination: { to_addresses: [ email ] },
          message: {
            subject: {
              charset: "UTF-8",
              data: "⚠️ Alerta crítica en MailerAction"
            },
            body: {
              html: {
                charset: "UTF-8",
                data: <<~HTML
                  <h2 style="color:#cc0000;">🚨 Alerta del sistema MailerAction</h2>
                  <p><strong>Hora:</strong> #{Time.zone.now.strftime("%d/%m/%Y %H:%M")}</p>
                  <p><strong>Servidor:</strong> #{Socket.gethostname}</p>
                  <p><strong>Nivel de criticidad:</strong> <span style="color:#cc0000;font-weight:bold;">ALTO</span></p>
                  <hr>
                  <p><strong>Mensaje:</strong></p>
                  <p style="background-color:#f8f8f8;padding:10px;border-left:4px solid #cc0000;">
                    #{message}
                  </p>
                  <hr>
                  <p style="font-size:12px;color:#888;">Este mensaje fue generado automáticamente por el sistema de monitoreo de MailerAction.</p>
                HTML
              }
            }
          },
          source: sender,
          reply_to_addresses: [ "soporte@maileraction.com" ]
        })

        Rails.logger.info "✅ Alerta enviada a admin: #{email}"
      rescue Aws::SES::Errors::ServiceError => e
        Rails.logger.error "❌ Error al enviar alerta a #{email}: #{e.message}"
      end
    end
  end
end
