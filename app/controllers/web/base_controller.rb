# app/controllers/web/base_controller.rb
module Web
  class BaseController < ActionController::Base
    layout "application"

    protect_from_forgery with: :exception
    before_action :set_locale

    before_action :authenticate_user!
    helper_method :current_user

    skip_forgery_protection if: -> { request.format.json? }

    include ActionController::Cookies
    include ActionController::Helpers
    include ActionController::Flash

    # Método para obtener el usuario actual usando UUID
    def current_user
      @current_user ||= User.find_by(uuid: session[:user_uuid])
    end

    private

    # Método de autenticación para verificar si el usuario está autenticado
    def authenticate_user!
      unless session[:user_uuid]
        session[:return_to] = request.fullpath
        redirect_to web_login_path, alert: "Inicia sesión para continuar" and return
      end
    end

    # seleccionar el idioma por defecto
    def set_locale
      I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
    end
  end
end
