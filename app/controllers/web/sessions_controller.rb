# app/controllers/web/sessions_controller.rb
module Web
  class SessionsController < BaseController
    skip_before_action :authenticate_user!, only: [ :new, :create ]
    layout "application"  # Asegúrate de que se esté usando el layout correcto
    def new
      # Acción para mostrar el formulario de inicio de sesión
    end

    def create
      user = User.find_by(email_address: params[:email_address])

      if user&.authenticate(params[:password])
        session[:user_id] = user.id  # Guarda al usuario en la sesión
        redirect_after_login(user)

        # Recordar al usuario si la opción "Recordarme" está seleccionada
        if params[:remember_me] == "1"
          cookies.permanent[:user_id] = user.id
          cookies.permanent[:remember_token] = user.remember_token
        end
      else
        flash.now[:alert] = "Email o contraseña incorrectos"
        # render :new
        redirect_to web_login_path
      end
    end

    def destroy
      session[:user_id] = nil
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
      redirect_to root_path, notice: "Sesión cerrada correctamente"
    end


    private

    #    # Método para redirigir al usuario después de iniciar sesión
    #    def redirect_after_login(user)
    #      case user.role
    def redirect_after_login(user)
      case user.role.to_sym
      when :admin
        redirect_to web_dashboard_admin_dashboard_path
      when :campaign_manager
        redirect_to web_dashboard_campaigns_dashboard_path
      when :usuario_prepago, :colaborador_prepago
        redirect_to web_dashboard_prepaid_dashboard_path
      when :designer
        redirect_to web_templates_path
      when :analyst, :observer, :observador_prepago
        redirect_to web_campaign_reports_path
      else
        redirect_to web_dashboard_dashboard_path, notice: "Bienvenido a MailerAction"
      end
    end
  end
end
