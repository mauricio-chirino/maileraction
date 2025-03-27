# app/services/email_event_logger.rb
#
# Este servicio encapsula la lógica para registrar eventos relacionados con
# correos electrónicos (como rebotes, aperturas, clics, etc.) en una tabla EmailEventLog.

# Te permite centralizar este tipo de lógica, lo que:
# Hace tu código más limpio y DRY.

# Permite registrar nuevos tipos de eventos en el futuro con un solo método reutilizable.
#
# email: → la dirección de correo afectada por el evento.
# campaign: → la campaña a la que pertenece ese correo.
# event_type: → un string como "bounce", "open", "click", etc.
# metadata: → un hash opcional con detalles adicionales (ej: { refunded_credit: true }).
#
class EmailEventLogger
  def self.call(email:, campaign:, event_type:, metadata: {})
    EmailEventLog.create!(
      email: email,
      campaign: campaign,
      event_type: event_type,
      metadata: metadata
    )
  end
end
