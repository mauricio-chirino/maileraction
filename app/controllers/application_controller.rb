# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  include Pundit::Authorization

  # Setea zona horaria si viene del header
  around_action :set_time_zone_from_header

  # Autenticación global (excepto acciones públicas como login/signup/webhooks)
  before_action :authenticate_user_with_jwt!, unless: :open_action?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # Autenticación por JWT
  def authenticate_user_with_jwt!
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last
    if token.blank?
      return render json: { error: "No autorizado. Debes iniciar sesión." }, status: :unauthorized
    end

    begin
      decoded = JWT.decode(token, Rails.application.credentials[:secret_key_base])[0]
      if decoded["exp"] && Time.at(decoded["exp"]) < Time.now
        return render json: { error: "Token expirado, inicia sesión de nuevo." }, status: :unauthorized
      end
      @current_user = User.find_by!(uuid: decoded["user_id"]) # Usa uuid
    rescue JWT::ExpiredSignature
      render json: { error: "Token expirado." }, status: :unauthorized
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "Token inválido o usuario no encontrado." }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  # Acciones abiertas (no requieren autenticación)
  def open_action?
    (controller_name == "sessions" && action_name == "create") ||
    (controller_name == "users" && action_name == "create") ||
    (controller_name == "webhooks")
  end

  def user_not_authorized
    render json: { error: "No autorizado" }, status: :forbidden
  end

  def set_time_zone_from_header(&block)
    time_zone = request.headers["Time-Zone"]
    if time_zone.present? && ActiveSupport::TimeZone[time_zone]
      Time.use_zone(time_zone, &block)
    else
      Time.use_zone("UTC", &block)
    end
  end
end
