module Api
  module V1
    class PasswordsController < ApplicationController
      skip_before_action :authenticate_user_with_jwt!

      # POST /api/v1/password/forgot
      def forgot
        user = User.find_by(email_address: params[:email_address])
        if user
          user.send_password_reset_email # implementa este método en tu modelo User si no existe
        end
        render json: { message: "Si el correo existe, se ha enviado el email de recuperación." }
      end

      # PUT /api/v1/password/reset
      def reset
        user = User.find_by(password_reset_token: params[:token])
        if user&.password_reset_sent_at && user.password_reset_sent_at > 2.hours.ago
          if user.update(password_params)
            render json: { message: "Contraseña restablecida correctamente." }
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "Token inválido o expirado." }, status: :unprocessable_entity
        end
      end

      private

      def password_params
        params.permit(:password, :password_confirmation)
      end
    end
  end
end
