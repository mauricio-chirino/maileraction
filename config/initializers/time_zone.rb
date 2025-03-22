# Establece la zona horaria por request usando un header enviado por el cliente
Rails.application.config.middleware.use(
  ->(env) {
    request = ActionDispatch::Request.new(env)
    time_zone = request.headers["X-Time-Zone"]

    Time.use_zone(time_zone.presence || Rails.application.config.time_zone) do
      status, headers, response = Rails.application.call(env)
      [ status, headers, response ]
    end
  }
)
