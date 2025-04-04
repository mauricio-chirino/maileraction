# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, key: "session_id", same_site: :lax


Rails.application.config.middleware.use ActionDispatch::Cookies
Rails.application.config.middleware.use ActionDispatch::Session::CookieStore, key: "_maileraction_session"
