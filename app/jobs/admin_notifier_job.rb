class AdminNotifierJob < ApplicationJob
  queue_as :default

  def perform(message)
    admin_emails = User.where(role: "admin").pluck(:email_address) # ajustá si usás otra lógica de roles
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
              data: "⚠️ Alerta en MailerAction"
            },
            body: {
              text: {
                charset: "UTF-8",
                data: message
              }
            }
          },
          source: sender
        })
        Rails.logger.info "✅ Alerta enviada a admin: #{email}"
      rescue Aws::SES::Errors::ServiceError => e
        Rails.logger.error "❌ Error al enviar alerta a #{email}: #{e.message}"
      end
    end
  end
end
