Rails.application.routes.draw do
  get "home/index"
  resource :session
  resources :passwords, param: :token
  post "/login", to: "sessions#create"
  get "up" => "rails/health#show", as: :rails_health_check
  get "web/password_reset/:token", to: "web/passwords#edit", as: "edit_web_password_reset"

  # API Version 1
  namespace :api do
    namespace :v1 do
      post "sessions", to: "sessions#create"

      delete "sessions", to: "sessions#destroy"

      get "me", to: "users#me"

      get "users/me", to: "users#me"

      namespace :admin do
        post "industries/reset_counts", to: "industries#reset_counts"
      end

      resources :templates, param: :uuid do
        member { get :preview }
      end

      resources :templates, only: [ :index, :create, :show, :update, :destroy ], param: :uuid
      get "template/index"
      get "template/show"
      get "template/create"
      get "template/update"
      get "template/destroy"

      resources :industries, only: [ :index ]

      get "industries/email_counts", to: "industries#email_counts"
      get "/api/v1/public_email_records/search", to: "public_email_records#search"
      get "credit_account", to: "credit_accounts#show"
      post "credit_accounts/assign_initial", to: "credit_accounts#assign_initial"
      post "credit_accounts/consume", to: "credit_accounts#consume"
      post "credit_accounts/consume_campaign", to: "credit_accounts#consume_campaign"
      post "webhooks/aws_ses", to: "webhooks#aws_ses"
      post "webhooks/aws_ses_tracking", to: "webhooks#aws_ses_tracking"

      resources :support_requests, only: [ :create, :index, :show, :update ], param: :uuid

      resources :industries, only: [ :index, :show ]

      post "scrape", to: "scrapings#create"

      resources :public_email_records, only: [ :index ], param: :uuid

      resources :scrape_targets, only: [ :create ], param: :uuid

      resources :public_email_records, only: [ :index, :show, :create ], param: :uuid do
        collection do
          get :by_industry
          get :by_region
          get :search
        end
      end

      resources :campaigns, only: [ :index, :create, :show, :update, :destroy ], param: :uuid do
        # --- Aquí va el nested resource ---
        resources :email_blocks, only: [ :index, :create, :show, :update, :destroy ], param: :uuid


        member do
          get :stats
          post :send_campaign
          post :cancel
        end
        collection do
          get :monthly_summary
        end
      end



      resources :transactions, only: [ :index, :create ], param: :uuid

      resources :email_logs, only: [ :index, :show ], param: :uuid

      resources :bounces, only: [ :index, :show ], param: :uuid

      get "emails/available_count/:industry_id", to: "emails#available_count"
      post "webhooks/:provider", to: "webhooks#receive"
    end
  end

  scope "(:locale)", locale: /es|en|fr|br|de|it/ do
    delete "logout", to: "sessions#destroy", as: :logout
    namespace :web do
      delete "logout", to: "sessions#destroy", as: :web_logout

      # Usa param: :uuid en recursos relevantes
      resources :users, only: [ :index, :edit, :show, :update ], param: :uuid
      get "/account/settings", to: "accounts#settings", as: :account_settings

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
      namespace :support do
        get :index
        get :customer_support
        get :migrate_to_maileraction
        get :report_spam
        get :tutorials
        get :deliverability_diagnostics
      end
      namespace :resources do
        get :index
        get :blog
        get :success_stories
        get :webinars_and_events
        get :guides_and_tutorials
      end
      namespace :community do
        get :index
        get :user_forum
        get :referral_program
        get :developer_community
      end
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
      namespace :legal do
        get :index
        get :terms_of_service
        get :privacy_policy
        get :cookie_settings
        get :security
        get :brand_assets
      end
      namespace :dashboard do
        get "admin_dashboard",     to: "dashboards#admin",     as: :admin_dashboard
        get "campaigns_dashboard", to: "dashboards#campaigns", as: :campaigns_dashboard
        get "prepaid_dashboard",   to: "dashboards#prepaid",   as: :prepaid_dashboard
        get "dashboard",           to: "dashboards#default",   as: :dashboard

        get "campaign_preview", to: "dashboards#campaign_preview"
        get "scheduled_campaigns", to: "dashboards#scheduled"
        get "campaigns/:uuid/edit_modal", to: "dashboards#edit_modal", as: :campaign_edit_modal
        patch "campaigns/:uuid", to: "dashboards#update", as: :campaign
        get "sent_campaigns", to: "dashboards#sent"
        get "campaigns/block_html", to: "campaigns#block_html"
        get "inspector/:category/:block_type", to: "inspector#show_property", as: :inspector_property
      end

      resources :campaigns, only: [ :edit, :update, :show ], controller: "dashboard/campaigns", param: :uuid do
        member do
          get :editor
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
  end

  mount ActionCable.server => "/cable"
  root to: "web/home#index"
end
