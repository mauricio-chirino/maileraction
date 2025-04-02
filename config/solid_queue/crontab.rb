# config/solid_queue/crontab.rb

require_relative "../../config/environment"

SolidQueue.cron do
  # Ejecuta todos los días a las 5:00 AM hora del servidor
  schedule "0 5 * * *", job: "EnhancePublicEmailRecordsJob"
  # Alternativa: Ejecuta todos los días a las 2:00 AM hora del servidor
  # schedule "0 2 * * *", job: "EnhancePublicEmailRecordsJob"
  #
  schedule "30 5 * * *", job: "EmailValidationJob"  # Todos los días a las 5:30 AM
end
