# app/controllers/web/base_controller.rb
module Web
  class BaseController < ActionController::Base
    before_action :set_locale

    # Asegura que el usuario esté autenticado antes de ejecutar las acciones (excepto en acciones específicas como el login)
    before_action :authenticate_user!

    # Esto hace que esté disponible en las vistas
    helper_method :current_user

    # Si la petición es JSON, no aplicar protección CSRF
    skip_forgery_protection if: -> { request.format.json? }

    # Incluir cookies y helpers para flash y manejo de sesiones
    include ActionController::Cookies
    include ActionController::Helpers
    include ActionController::Flash



    private

    # Método de autenticación para verificar si el usuario está autenticado
    def authenticate_user!
      unless session[:user_id]
        session[:return_to] = request.fullpath
        redirect_to web_login_path, alert: "Inicia sesión para continuar" and return
      end
    end

    # Método para obtener el usuario actual
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end


    # seleccionar el idioma por defecto
    def set_locale
      I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
      session[:locale] = I18n.locale
    end
  end
end
