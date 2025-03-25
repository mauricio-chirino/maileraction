module Notifications
  class SendEmailJob < ApplicationJob
    queue_as :default

    def perform(notification_id)
      notification = Notification.find_by(id: notification_id)
      return unless notification

      user = notification.user
      return unless user&.email_address

      ses = Aws::SES::Client.new
      sender = Rails.application.credentials.dig(:mailer, :from_email)

      begin
        ses.send_email({
          destination: {
            to_addresses: [ user.email_address ]
          },
          message: {
            subject: {
              charset: "UTF-8",
              data: notification.title
            },
            body: {
              html: {
                charset: "UTF-8",
                data: "<p>#{notification.body}</p>"
              }
            }
          },
          source: sender
        })

        puts "📧 Notificación enviada a #{user.email_address} vía SES"
        notification.update!(email_sent_at: Time.current)

      rescue Aws::SES::Errors::ServiceError => e
        puts "❌ Falló el envío de notificación por email: #{e.message}"
      end
    end
  end
end
