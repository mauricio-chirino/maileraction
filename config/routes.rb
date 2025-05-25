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
    # cambiar de idioma

    # Tus rutas existentes...





    get "home/index"
    # Autenticación
    resource :session
    resources :passwords, param: :token
    post "/login", to: "sessions#create"
    # delete "/logout", to: "sessions#destroy"

    # Ruta de estado para health check
    get "up" => "rails/health#show", as: :rails_health_check

    # Ruta para restablecer la contraseña
    get "web/password_reset/:token", to: "web/passwords#edit", as: "edit_web_password_reset"



    # API Version 1
    namespace :api do
      namespace :v1 do
        #
        #
        # # Rutas para la gestión de la sesión en la API
        post "sessions", to: "sessions#create"  # Login
        delete "sessions", to: "sessions#destroy"  # Logout


        # Rutas para obtener información del usuario autenticado
        get "me", to: "users#me"


        # Rutas de administración
        # Rutas de administración para la API
        namespace :admin do
          post "industries/reset_counts", to: "industries#reset_counts"
        end


        # Plantillas
        # Rutas para la gestión de plantillas
        # /api/v1/templates
        # /api/v1/templates/:id
        # /api/v1/templates/:id/preview
        resources :templates do
          member do
            get :preview
          end
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


          collection do
            get :monthly_summary
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




      # Configuración de rutas locales
      scope "(:locale)", locale: /es|en|fr|br|de|it/ do
        delete "logout", to: "sessions#destroy", as: :logout
        namespace :web do
          delete "logout", to: "sessions#destroy", as: :web_logout

          resources :users, only: [ :index, :edit, :show, :update ]

          get "/account/settings", to: "accounts#settings", as: :account_settings






          # Producto
          namespace :product do
            get :index
            get :email_marketing
            get :automate
            get :websites
            get :transactional_email
            get :integrations
            get :compare_mailer_action
            get :developer_api
            get :news
            get :templates
          end

          # Soporte
          namespace :support do
            get :index
            get :customer_support
            get :migrate_to_maileraction
            get :report_spam
            get :tutorials
            get :deliverability_diagnostics
          end

          # Recursos
          namespace :resources do
            get :index
            get :blog
            get :success_stories
            get :webinars_and_events
            get :guides_and_tutorials
          end

          # Comunidad
          namespace :community do
            get :index
            get :user_forum
            get :referral_program
            get :developer_community
          end

          # Empresa
          namespace :company do
            get :index
            get :about_us
            get :why_maileraction
            get :values
            get :partners
            get :gdpr_compliance
            get :corporate_responsibility
            get :contact_us
          end

          # Legal
          namespace :legal do
            get :index
            get :terms_of_service
            get :privacy_policy
            get :cookie_settings
            get :security
            get :brand_assets
          end


          # Dashboard
          namespace :dashboard do
            get "admin_dashboard",     to: "dashboards#admin",     as: :admin_dashboard
            get "campaigns_dashboard", to: "dashboards#campaigns", as: :campaigns_dashboard
            get "prepaid_dashboard",   to: "dashboards#prepaid",   as: :prepaid_dashboard
            get "dashboard",           to: "dashboards#default",   as: :dashboard

            # Ruta para obtener la vista previa de la campaña
            get "campaign_preview", to: "dashboards#campaign_preview"
            get "web/dashboard/scheduled_campaigns", to: "web/dashboard/dashboards#scheduled"

            get "campaigns/:id/edit_modal", to: "dashboards#edit_modal", as: :campaign_edit_modal
            patch "campaigns/:id", to: "dashboards#update", as: :campaign



            get "sent_campaigns", to: "dashboards#sent"

            # los bloques drop
            get "campaigns/block_html", to: "campaigns#block_html"
          end


          # patch "update_campaign/:id", to: "dashboards#update_campaign", as: :update_campaign




          # Campañas (frontend)
          resources :campaigns, only: [ :edit, :update, :show ], controller: "dashboard/campaigns" do
            member do
              # delete :cancel
              get :editor # ← aquí se agrega la nueva ruta para el editor visual
            end
          end



          # Rutas de administración de sesión
          get "/login", to: "sessions#new"
          post "/login", to: "sessions#create"
          # delete "/logout", to: "sessions#destroy"

          # Rutas para registro
          get "/signup", to: "registrations#new"
          post "/signup", to: "registrations#create"

          # Rutas de contraseñas
          get "/forgot_password", to: "passwords#new", as: "forgot_password"
          post "/forgot_password", to: "passwords#create", as: "password_reset"
          get "/password_reset/:token", to: "passwords#edit", as: "reset_password"
          patch "/password_reset/:token", to: "passwords#update"



          # Página principal
          root to: "home#index"
        end
      end


  # Página principal
  # root to: "web/home#index"
  root to: "web/home#index"
end
