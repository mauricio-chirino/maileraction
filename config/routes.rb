# Configuración de rutas para la aplicación Rails.
#
# Rutas principales:
# - resource :session: Define rutas para la sesión del usuario.
# - resources :passwords, param: :token: Define rutas para la gestión de contraseñas utilizando un token.
# - post "/login": Ruta para iniciar sesión.
# - delete "/logout": Ruta para cerrar sesión.
# - get "up": Ruta para verificar el estado de la aplicación (health check).
#
# API Version 1:
# - namespace :api: Define un espacio de nombres para la API.
# - namespace :v1: Define la versión 1 de la API.
# - get "template/index": Ruta para listar plantillas.
# - get "template/show": Ruta para mostrar una plantilla específica.
# - get "template/create": Ruta para crear una nueva plantilla.
# - get "template/update": Ruta para actualizar una plantilla existente.
# - get "template/destroy": Ruta para eliminar una plantilla.
# - get "me": Ruta para obtener información del usuario autenticado.
# - get "credit_account": Ruta para mostrar la cuenta de crédito.
# - post "credit_accounts/assign_initial": Ruta para asignar crédito inicial.
# - post "credit_accounts/consume": Ruta para consumir crédito.
# - post "credit_accounts/consume_campaign": Ruta para consumir crédito en una campaña.
# - resources :templates: Define rutas para las operaciones CRUD de plantillas.
# - resources :support_requests: Define rutas para la creación de solicitudes de soporte.
# - resources :industries: Define rutas para listar y mostrar industrias.
# - resources :campaigns: Define rutas para las operaciones CRUD de campañas, incluyendo estadísticas y envío de campañas.
# - resources :transactions: Define rutas para listar y crear transacciones.
# - resources :email_logs: Define rutas para listar y mostrar registros de correos electrónicos.
# - resources :bounces: Define rutas para listar y mostrar rebotes de correos electrónicos.
# - get "emails/available_count/:industry_id": Ruta para obtener el conteo de correos disponibles por industria.
# - post "webhooks/:provider": Ruta para recibir webhooks de diferentes proveedores (Stripe, MercadoPago, etc.).
Rails.application.routes.draw do
  # Autenticación
  resource :session
  resources :passwords, param: :token
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Ruta de estado para health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API Version 1
  namespace :api do
    namespace :v1 do
      # Rutas de administración
      # Rutas de administración para la API
      namespace :admin do
        post "industries/reset_counts", to: "industries#reset_counts"
      end






      # Templates
      resources :templates, only: [ :index, :create, :show, :update, :destroy ]
      get "template/index"
      get "template/show"
      get "template/create"
      get "template/update"
      get "template/destroy"


      #
      resources :industries, only: [ :index ]
      # Ruta para obtener el conteo de correos electrónicos por industria
      # /industries/email_counts
      get "industries/email_counts", to: "industries#email_counts"




      # Ruta para obtener correos  electrónicos disponibles por industria
      get "/api/v1/public_email_records/search", to: "public_email_records#search"



      # Usuarios
      get "me", to: "users#me"



      # Cuentas de crédito
      get "credit_account", to: "credit_accounts#show"
      post "credit_accounts/assign_initial", to: "credit_accounts#assign_initial"
      post "credit_accounts/consume", to: "credit_accounts#consume"
      post "credit_accounts/consume_campaign", to: "credit_accounts#consume_campaign"

      # Webhooks de Stripe
      # Webhooks de AWS SES
      post "webhooks/aws_ses", to: "webhooks#aws_ses" # Ruta para recibir webhooks de AWS SES
      post "webhooks/aws_ses_tracking", to: "webhooks#aws_ses_tracking" # Ruta para recibir webhooks de seguimiento de AWS SES


      # Solicitudes de soporte
      resources :support_requests, only: [ :create, :index, :show, :update ]

      # Rubros (Industrias)
      resources :industries, only: [ :index, :show ]





      # Scraping de correos electrónicos
      # Ruta para iniciar el scraping de correos electrónicos
      post "scrape", to: "scrapings#create"

      # Ruta para obtener el estado de los scraping
      resources :public_email_records, only: [ :index ]

      # Ruta para obtener el estado de los scraping
      # /api/v1/scrape_targets
      # /api/v1/scrape_targets/:id
      # /api/v1/scrape_targets/:id/stop
      # /api/v1/scrape_targets/:id/start
      # /api/v1/scrape_targets/:id/force_stop
      resources :scrape_targets, only: [ :create ]


      # Registros de correos electrónicos públicos
      resources :public_email_records, only: [ :index, :show, :create ] do
        collection do
          get :by_industry
          get :by_region
          get :search # /api/v1/public_email_records/search?industry=Retail&limit=10
        end
      end




      # Campañas
      resources :campaigns, only: [ :index, :create, :show, :update, :destroy ] do
        member do
          get :stats              # /api/v1/campaigns/:id/stats
          post :send_campaign     # /api/v1/campaigns/:id/send_campaign
          post :cancel            # /api/v1/campaigns/:id/cancel
        end
      end

      # Transacciones
      resources :transactions, only: [ :index, :create ]

      # Registros de correos electrónicos
      resources :email_logs, only: [ :index, :show ]

      # Rebotes de correos electrónicos
      resources :bounces, only: [ :index, :show ]

      # Correos disponibles (por industria)
      get "emails/available_count/:industry_id", to: "emails#available_count"

      # Webhooks (Stripe, MercadoPago, etc.)
      post "webhooks/:provider", to: "webhooks#receive"
    end
  end
end
