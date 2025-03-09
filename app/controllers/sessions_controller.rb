class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    
    if user&.authenticate(params[:password])
      render json: { token: generate_token(user), user: user }, status: :ok
    else
      render json: { error: 'Credenciales inválidas' }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: "Sesión cerrada correctamente" }, status: :ok
  end

  private

  def generate_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
