# app/services/notification_sender.rb
#
# Encapsula la creación de notificaciones internas del sistema para un usuario. Por ejemplo:

# Aviso de campaña completada.

# Alerta por crédito devuelto.
# Errores de envío.
# Etc.
#
# Recibe:
#   user: → instancia del usuario al que se le va a enviar la notificación.
#   title: → título de la notificación (ej: "Crédito devuelto por rebote").
#   body: → contenido del mensaje.

# Hace:
#   Crea un registro en la tabla notifications usando Notification.create!.
#
class NotificationSender
  def self.call(user:, title:, body:)
    Notification.create!(
      user: user,
      title: title,
      body: body
    )
  end
end
