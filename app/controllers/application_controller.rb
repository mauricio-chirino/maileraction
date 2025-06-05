# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  # Soporte para políticas (roles/permisos)
  include Pundit::Authorization

  # Setear zona horaria desde header
  around_action :set_time_zone_from_header

  # Autenticación global usando JWT (puedes exceptuar controllers como sessions, signup, etc)
  before_action :authenticate_user_with_jwt!, unless: :open_action?

  # Manejo de errores de autorización (Pundit)
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # --- AUTENTICACIÓN JWT ---
  def authenticate_user_with_jwt!
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last
    if token.blank?
      return render json: { error: "No autorizado. Debes iniciar sesión." }, status: :unauthorized
    end

    begin
      decoded = JWT.decode(token, Rails.application.credentials[:secret_key_base])[0]
      # Valida expiración
      if decoded["exp"] && Time.at(decoded["exp"]) < Time.now
        return render json: { error: "Token expirado, inicia sesión de nuevo." }, status: :unauthorized
      end
      @current_user = User.find(decoded["user_id"])
    rescue JWT::ExpiredSignature
      render json: { error: "Token expirado." }, status: :unauthorized
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "Token inválido o usuario no encontrado." }, status: :unauthorized
    end
  end

  # Métodos auxiliares globales
  def current_user
    @current_user
  end

  # Permitir acciones abiertas (por ejemplo login, signup, webhooks públicos, etc)
  def open_action?
    # Ajusta estos controladores/acciones según tus necesidades.
    # Ejemplo: permitir que Api::V1::SessionsController y Api::V1::UsersController#create sean públicos:
    (controller_name == "sessions" && action_name == "create") ||
    (controller_name == "users" && action_name == "create") ||
    (controller_name == "webhooks") # Agrega otros si tienes webhooks públicos
  end

  # --- PUNDIt: No autorizado ---
  def user_not_authorized
    render json: { error: "No autorizado" }, status: :forbidden
  end

  # --- ZONA HORARIA por HEADER ---
  def set_time_zone_from_header(&block)
    time_zone = request.headers["Time-Zone"]
    if time_zone.present? && ActiveSupport::TimeZone[time_zone]
      Time.use_zone(time_zone, &block)
    else
      Time.use_zone("UTC", &block)
    end
  end
end
