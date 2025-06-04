# app/controllers/api/v1/sessions_controller.rb
class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Rails.logger.info "PARAMS: #{params.inspect}"
    user = User.find_by(email_address: params[:email_address])

    if user&.authenticate(params[:password])  # Suponiendo que has configurado 'has_secure_password' en el modelo User
      # Aquí se genera un token JWT
      token = generate_jwt_token(user)
      render json: { message: "Sesión iniciada", token: token }, status: :ok
    else
      render json: { error: "Email o contraseña inválidos" }, status: :unauthorized
    end
  end

  def destroy
    # Aquí podrías invalidar el token si lo deseas, dependiendo de cómo manejes la autenticación JWT
    render json: { message: "Sesión cerrada correctamente" }, status: :ok
  end

  private




  def generate_jwt_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.credentials[:secret_key_base])
  end
end
