class ApplicationController < ActionController::API
  around_action :set_time_zone_from_header

  include Authentication  # 👈 este es el bueno Este es el que maneja la autenticación
  include Pundit::Authorization
  # agrgados************************************
  include ActionController::Cookies
  include ActionController::Helpers

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Aplica la autenticación globalmente, excepto para el login y la recuperación de contraseñas
  before_action :authenticate_user!, except: [ :new, :create, :forgot_password, :reset_password ]


  private







  def authenticate_user!
    # Esto es donde se verifica si el usuario está autenticado
    unless session[:user_id]
      render json: { error: "No autorizado. Iniciá sesión." }, status: :unauthorized
    end
  end



  def user_not_authorized
    render json: { error: "No autorizado" }, status: :forbidden
  end

  def set_time_zone_from_header(&block)
    time_zone = request.headers["Time-Zone"]
    if time_zone.present? && ActiveSupport::TimeZone[time_zone]
      Time.use_zone(time_zone, &block)
    else
      # fallback por defecto
      Time.use_zone("UTC", &block)
    end
  end
end
