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
  # Home y autenticación web
  get "home/index"
  resource :session
  resources :passwords, param: :token
  post "/login", to: "sessions#create"
  get "up" => "rails/health#show", as: :rails_health_check
  get "web/password_reset/:token", to: "web/passwords#edit", as: "edit_web_password_reset"

  # API Version 1
  namespace :api do
    namespace :v1 do
      post "password/forgot", to: "passwords#forgot"
      put  "password/reset",  to: "passwords#reset"

      # Sesiones API (JWT)
      post "sessions", to: "sessions#create"
      delete "sessions", to: "sessions#destroy"

      # Usuario actual
      get "me", to: "users#me"

      # Admin API
      namespace :admin do
        post "industries/reset_counts", to: "industries#reset_counts"
      end

      # Industrias (rubros)
      resources :industries, only: [ :index, :show ]
      get "industries/email_counts", to: "industries#email_counts"

      # Plantillas de email
      resources :templates, only: [ :index, :create, :show, :update, :destroy ] do
        member { get :preview }
      end

      # Cuentas de crédito
      get  "credit_account",                 to: "credit_accounts#show"
      post "credit_accounts/assign_initial", to: "credit_accounts#assign_initial"
      post "credit_accounts/consume",        to: "credit_accounts#consume"
      post "credit_accounts/consume_campaign", to: "credit_accounts#consume_campaign"

      # Email Logs
      resources :email_logs, only: [ :index, :show ]

      # Rebotes
      resources :bounces, only: [ :index, :show ]

      # Soporte
      resources :support_requests, only: [ :create, :index, :show, :update ]

      # Campañas
      resources :campaigns, only: [ :index, :create, :show, :update, :destroy ] do
        member do
          get  :stats
          post :send_campaign
          post :cancel
          post :clear_canvas
        end
        collection do
          get :monthly_summary
        end
        resources :email_blocks, only: [ :index, :create, :update, :destroy ]
      end

      # Transacciones
      resources :transactions, only: [ :index, :create ]

      # Registros de emails públicos
      resources :public_email_records, only: [ :index, :show, :create ] do
        collection do
          get :by_industry
          get :by_region
          get :search
        end
      end

      # Scraping
      post "scrape", to: "scrapings#create"
      resources :scrape_targets, only: [ :create ]

      # Webhooks
      post "webhooks/aws_ses",          to: "webhooks#aws_ses"
      post "webhooks/aws_ses_tracking", to: "webhooks#aws_ses_tracking"
      post "webhooks/:provider",        to: "webhooks#receive"
    end
  end

  # Rutas frontend/web
  scope "(:locale)", locale: /es|en|fr|br|de|it/ do
    delete "logout", to: "sessions#destroy", as: :logout

    namespace :web do
      delete "logout", to: "sessions#destroy", as: :web_logout

      resources :users, only: [ :index, :edit, :show, :update ]
      get "/account/settings", to: "accounts#settings", as: :account_settings
      resources :templates, only: [ :index, :show ]
      # Producto, soporte, recursos, comunidad, empresa, legal... (omite aquí por espacio, igual que ya tienes)

      # Dashboard (simplificado, copia lo tuyo si necesitas más)
      namespace :dashboard do
        get "admin_dashboard",     to: "dashboards#admin",     as: :admin_dashboard
        get "campaigns_dashboard", to: "dashboards#campaigns", as: :campaigns_dashboard
        get "prepaid_dashboard",   to: "dashboards#prepaid",   as: :prepaid_dashboard
        get "dashboard",           to: "dashboards#default",   as: :dashboard

        get "campaign_preview", to: "dashboards#campaign_preview"
        get "scheduled_campaigns", to: "dashboards#scheduled"
        get "campaigns/:id/edit_modal", to: "dashboards#edit_modal", as: :campaign_edit_modal
        patch "campaigns/:id", to: "dashboards#update", as: :campaign
        get "sent_campaigns", to: "dashboards#sent"
        get "campaigns/block_html", to: "campaigns#block_html"
        get "inspector/:category/:block_type", to: "inspector#show_property", as: :inspector_property
        resources :templates, only: [ :index, :show ]
      end

      resources :campaigns, only: [ :edit, :update, :show ], controller: "dashboard/campaigns" do
        member do
          delete :remove_block
          get :editor
          post :add_block
          post :clear_canvas
        end
      end

      get "/login", to: "sessions#new"
      post "/login", to: "sessions#create"
      get "/signup", to: "registrations#new"
      post "/signup", to: "registrations#create"
      get "/forgot_password", to: "passwords#new", as: "forgot_password"
      post "/forgot_password", to: "passwords#create", as: "password_reset"
      get "/password_reset/:token", to: "passwords#edit", as: "reset_password"
      patch "/password_reset/:token", to: "passwords#update"
    end

    mount ActionCable.server => "/cable"
  end

  root to: "web/home#index"
end
