# class PasswordsController < ApplicationController
#   allow_unauthenticated_access
#   before_action :set_user_by_token, only: %i[ edit update ]
#   skip_before_action :authenticate_user!, only: [ :new, :create, :edit, :update ]

#   def new
#   end

#   def create
#     if user = User.find_by(email_address: params[:email_address])
#       PasswordsMailer.reset(user).deliver_later
#     end

#     redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
#   end

#   def edit
#   end

#   def update
#     if @user.update(params.permit(:password, :password_confirmation))
#       redirect_to new_session_path, notice: "Password has been reset."
#     else
#       redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
#     end
#   end

#   private
#     def set_user_by_token
#       @user = User.find_by_password_reset_token!(params[:token])
#     rescue ActiveSupport::MessageVerifier::InvalidSignature
#       redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
#     end
# end
# app/controllers/passwords_controller.rb
class PasswordsController < ApplicationController
  skip_before_action :authenticate_user_with_jwt!, raise: false # Por si usas API::API
  before_action :set_user_by_token, only: [ :edit, :update ]
  skip_before_action :authenticate_user!, only: [ :new, :create, :edit, :update ]

  def new
    # Renderiza formulario para ingresar el email
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    if user
      user.send_password_reset_email # Implementa este método en User
    end
    redirect_to new_session_path, notice: "Si el correo está registrado, te enviamos instrucciones para restablecer la contraseña."
  end

  def edit
    # Renderiza formulario para ingresar nueva contraseña (solo si el token es válido)
  end

  def update
    if @user.update(password_params)
      redirect_to new_session_path, notice: "Contraseña actualizada correctamente."
    else
      flash.now[:alert] = "No se pudo actualizar la contraseña."
      render :edit
    end
  end

  private

  def set_user_by_token
    @user = User.find_by(password_reset_token: params[:token])
    if @user.nil? || @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_path, alert: "Enlace de restablecimiento inválido o expirado."
    end
  end

  def password_params
    params.permit(:password, :password_confirmation)
  end
end
