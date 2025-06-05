module Authentication
  extend ActiveSupport::Concern

  require "jwt"

  included do
    # before_action :require_authentication
    before_action :authenticate_jwt_user!
    helper_method :authenticated? if respond_to?(:helper_method)
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end



  def authenticate_user!
    unless current_user
      render json: { error: "No autenticado" }, status: :unauthorized
    end
  end


  private
    def authenticated?
      resume_session
    end

    def require_authentication
      resume_session || request_authentication
    end

    def resume_session
      Current.session ||= find_session_by_cookie
    end

    def find_session_by_cookie
      Session.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
    end

    def request_authentication
      render json: { error: "No autorizado. Iniciá sesión." }, status: :unauthorized
    end

    def after_authentication_url
      session.delete(:return_to_after_authenticating) || root_url
    end

    def start_new_session_for(user)
      user.sessions.create!(
        user_agent: request.user_agent,
        ip_address: request.remote_ip
      ).tap do |session|
        Current.session = session
        cookies.signed.permanent[:session_id] = {
          value: session.id, httponly: true,
          same_site: :lax
        }
      end
    end

    def terminate_session
      Current.session.destroy
      cookies.delete(:session_id)
    end





  # def authenticate_jwt_user!
  #  header = request.headers["Authorization"]
  # token = header.split(" ").last if header

  # if token
  # begin
  #  decoded = JWT.decode(token, Rails.application.credentials[:secret_key_base], true, { algorithm: "HS256" })
  # user_id = decoded[0]["user_id"]
  # @current_user = User.find_by(id: user_id)
  # unless @current_user
  # render json: { error: "Usuario no encontrado" }, status: :unauthorized
  # end
  # rescue JWT::DecodeError, JWT::ExpiredSignature
  # render json: { error: "Token inválido o expirado" }, status: :unauthorized
  # end
  # else
  # render json: { error: "Token de autorización requerido" }, status: :unauthorized
  # end
  # end




  # def current_user
  #   return @current_user if defined?(@current_user)
  #   if request.headers["Authorization"].present?
  #     token = request.headers["Authorization"].split(" ").last
  #     begin
  #       payload = JWT.decode(token, Rails.application.credentials[:secret_key_base])[0]
  #       @current_user = User.find_by(id: payload["user_id"])
  #     rescue JWT::DecodeError, ActiveRecord::RecordNotFound
  #       @current_user = nil
  #     end
  #   end
  #   @current_user
  # end
end
