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


      get "credit_account", to: "credit_accounts#show"
      post "credit_accounts/assign_initial", to: "credit_accounts#assign_initial"
      post "credit_accounts/consume", to: "credit_accounts#consume"


      post "credit_accounts/consume_campaign", to: "credit_accounts#consume_campaign"




      # Rubros (Industries)
      resources :industries, only: [ :index, :show ]

      # Campañas
      resources :campaigns, only: [ :index, :create, :show, :update, :destroy ] do
        member do
          get :stats        # /api/v1/campaigns/:id/stats
          post :send        # /api/v1/campaigns/:id/send
        end
      end


      resources :transactions, only: [ :index, :create ]
      resources :email_logs, only: [ :index, :show ]
      resources :bounces, only: [ :index, :show ]

      # Correos disponibles (por industria)
      get "emails/available_count/:industry_id", to: "emails#available_count"

      # Webhooks (Stripe, MercadoPago, etc.)
      post "webhooks/:provider", to: "webhooks#receive"
    end
  end
end
