# app/controllers/web/registrations_controller.rb
module Web
  class RegistrationsController < BaseController
    layout "application"  # Asegúrate de que se esté usando el layout correcto
    # Muestra el formulario de registro
    def new
      @user = User.new
    end

    # Procesa el registro de usuario
    def create
      @user = User.new(user_params)

      # Llamamos al método para generar el remember_token
      @user.generate_remember_token_value

      if @user.save
        # Redirige a la página principal o donde desees
        redirect_to root_path, notice: "¡Registro exitoso! Ahora puedes iniciar sesión."
      else
        # Si hay un error, muestra el formulario nuevamente con los errores
        render :new
      end
    end

    private

    def user_params
      # Asegúrate de que los parámetros que estás permitiendo sean correctos
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
  end
end
