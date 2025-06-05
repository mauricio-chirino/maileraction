require_relative "boot"

require "rails/all"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Maileraction
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0
    config.active_job.queue_adapter = :solid_queue

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true # era true
    config.middleware.use Rack::MethodOverride
    config.middleware.use ActionDispatch::Flash
    config.middleware.use ActionDispatch::Session::CookieStore, key: "_maileraction_session"


    config.middleware.use ActionDispatch::Cookies
    config.time_zone = "America/Santiago"
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets")
    config.assets.paths << Rails.root.join("node_modules")



    # configuracion envuio de email
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp

    config.action_mailer.smtp_settings = {
      address: "maileraction.com",              # Servidor de correo saliente
      port: 587,                               # Puerto SMTP
      domain: "maileraction.com",               # Dominio
      user_name: "support@maileraction.com",    # Nombre de usuario
      password: "528Kum9~l",                # Contraseña del correo (reemplaza 'your_password' con la contraseña real)
      authentication: "plain",                  # Tipo de autenticación
      enable_starttls_auto: true,               # Habilitar STARTTLS para cifrado
      ssl: true,                                # Usar SSL para seguridad
      tls: true                                 # Usar TLS para seguridad
    }



    # Cargar configuraciones predeterminadas
    config.load_defaults 6.0

    # Configuración de idiomas disponibles
    config.i18n.available_locales = [ :es, :en, :fr, :br, :de, :it ]

    # Configurar idioma por defecto
    config.i18n.default_locale = :es

    # Configuración para manejar locales en las rutas
    config.i18n.fallbacks = true
  end
end
