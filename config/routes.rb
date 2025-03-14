Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Autenticación (con UseAuthentication)
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Ruta de estado para health check
  get "up" => "rails/health#show", as: :rails_health_check

  # API Version 1
  namespace :api do
    namespace :v1 do
      get "me", to: "users#me"

      # Consultar creditos de un usuario
      resources :credit_accounts, only: [] do
        collection do
          post :assign_initial
          post :consume
        end
      end



      # Rubros (Industries)
      resources :industries, only: [ :index, :show ]

      # Campañas
      resources :campaigns, only: [ :index, :create, :show, :update, :destroy ] do
        member do
          get :stats        # /api/v1/campaigns/:id/stats
          post :send        # /api/v1/campaigns/:id/send
        end
      end

      # Créditos
      resources :credit_accounts, only: [ :show ]
      resources :transactions, only: [ :index, :create ]

      # Estadísticas
      resources :email_logs, only: [ :index, :show ]
      resources :bounces, only: [ :index, :show ]

      # Correos disponibles (por industria)
      get "emails/available_count/:industry_id", to: "emails#available_count"

      # Webhooks (Stripe, MercadoPago, etc.)
      post "webhooks/:provider", to: "webhooks#receive"
    end
  end
end
