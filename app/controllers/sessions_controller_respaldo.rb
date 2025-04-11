class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  # rate_limit to: 10, within: 3.minutes, only: :create, with: -> { head :too_many_requests }

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user&.authenticate(params[:password])
      start_new_session_for user
      render json: { message: "Sesión iniciada", user: user.email_address }, status: :ok
    else
      render json: { error: "Email o contraseña inválidos" }, status: :unauthorized
    end
  end

  # def destroy
  #   terminate_session
  #   redirect_to new_session_path
  # end
  #
  def destroy
    terminate_session
    render json: { message: "Sesión cerrada correctamente" }, status: :ok
  end

  # private

  # def generate_token(user)
  #   payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
  #   JWT.encode(payload, Rails.application.secrets.secret_key_base)
  # end



  # def create
  #   user = User.find_by(email: params[:email])

  #   if user&.authenticate(params[:password])
  #     render json: { token: generate_token(user), user: user }, status: :ok
  #   else
  #     render json: { error: 'Credenciales inválidas' }, status: :unauthorized
  #   end
  # end

  # def destroy
  #   render json: { message: "Sesión cerrada correctamente" }, status: :ok
  # end

  # private

  # def generate_token(user)
  #   payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
  #   JWT.encode(payload, Rails.application.secrets.secret_key_base)
  # end
end
