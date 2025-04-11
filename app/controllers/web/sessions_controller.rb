# app/controllers/web/sessions_controller.rb
module Web
  class SessionsController < BaseController
    def new
      # Acción para mostrar el formulario de inicio de sesión
    end

    def create
      user = User.find_by(email_address: params[:email_address])

      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "Sesión iniciada correctamente."
        redirect_to root_path
      else
        flash[:alert] = "Email o contraseña inválidos."
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
      flash[:notice] = "Sesión cerrada correctamente."
      redirect_to root_path
    end
  end
end
