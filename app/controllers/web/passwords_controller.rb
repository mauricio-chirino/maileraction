module Web
  class PasswordsController < BaseController
    layout "application"  # Asegúrate de que se esté usando el layout correcto
    # No es necesario estar autenticado para acceder a estas acciones
    skip_before_action :authenticate_user!, only: [ :new, :create, :edit, :update ]

    def new
      # Aquí se muestra el formulario para ingresar el correo de recuperación
    end

    def create
      @user = User.find_by(email_address: params[:email_address])

      if @user.present?
        # Si el correo está registrado, genera el token y lo envía
        @user.send_password_reset_email
        flash[:notice] = "Si el correo está registrado, te hemos enviado un enlace para restablecer tu contraseña."
        redirect_to web_login_path
      else
        # Si el correo no está registrado, muestra un mensaje de éxito para evitar el error
        flash[:notice] = "Si el correo está registrado, te hemos enviado un enlace para restablecer tu contraseña."
        redirect_to web_login_path
      end
    end

    def edit
      @user = User.find_by(password_reset_token: params[:token])


      if @user.nil? || @user.password_reset_sent_at < 2.hours.ago
        # Manejo de error si el token no es válido
        flash[:alert] = "El enlace de restablecimiento de contraseña ha caducado."
        # redirect_to web_forgot_password_path
        redirect_to root_path
      end
    end

    def update
      @user = User.find_by(password_reset_token: params[:token])

      if @user.update(password_params)
        flash[:notice] = "Tu contraseña ha sido actualizada con éxito."
        redirect_to web_login_path
      else
        flash.now[:alert] = "Hubo un error al actualizar la contraseña."
        render :edit
      end
    end

    private

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end
