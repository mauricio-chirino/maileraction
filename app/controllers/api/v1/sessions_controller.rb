# app/controllers/api/v1/sessions_controller.rb
module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email_address: params[:email_address])

        if user&.authenticate(params[:password])  # Suponiendo has_secure_password
          token = generate_jwt_token(user)
          render json: { message: "Sesión iniciada", token: token }, status: :ok
        else
          render json: { error: "Email o contraseña inválidos" }, status: :unauthorized
        end
      end

      def destroy
        # Aquí podrías invalidar el token si lo deseas
        render json: { message: "Sesión cerrada correctamente" }, status: :ok
      end

      private

      def generate_jwt_token(user)
        payload = { user_uuid: user.uuid, exp: 24.hours.from_now.to_i }
        JWT.encode(payload, Rails.application.credentials[:secret_key_base])
      end
    end
  end
end
