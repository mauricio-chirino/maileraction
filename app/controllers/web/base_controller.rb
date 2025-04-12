# app/controllers/web/base_controller.rb
module Web
  class BaseController < ActionController::Base
    # Si la petición es JSON, no aplicar protección CSRF
    skip_forgery_protection if: -> { request.format.json? }

    # Incluir cookies y helpers para flash y manejo de sesiones
    include ActionController::Cookies
    include ActionController::Helpers
    include ActionController::Flash

    # Asegura que el usuario esté autenticado antes de ejecutar las acciones (excepto en acciones específicas como el login)
    before_action :authenticate_user!

    private

    # Método de autenticación para verificar si el usuario está autenticado
    def authenticate_user!
      # Verifica si existe un id de usuario en la sesión, si no, devuelve error de no autorizado
      unless session[:user_id]
        render json: { error: "No autorizado. Iniciá sesión." }, status: :unauthorized
      end
    end
  end
end
