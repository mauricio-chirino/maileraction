# app/controllers/web/sessions_controller.rb
module Web
  class SessionsController < BaseController
    layout "application"  # Asegúrate de que se esté usando el layout correcto
    def new
      # Acción para mostrar el formulario de inicio de sesión
    end

    def create
      user = User.find_by(email_address: params[:email_address])

      if user&.authenticate(params[:password])
        session[:user_id] = user.id  # Guarda al usuario en la sesión

        # Recordar al usuario si la opción "Recordarme" está seleccionada
        if params[:remember_me] == "1"
          cookies.permanent[:user_id] = user.id
          cookies.permanent[:remember_token] = user.remember_token
        end

        redirect_to root_path, notice: "Sesión iniciada correctamente"
      else
        flash.now[:alert] = "Email o contraseña incorrectos"
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
      redirect_to root_path, notice: "Sesión cerrada correctamente"
    end
  end
end
