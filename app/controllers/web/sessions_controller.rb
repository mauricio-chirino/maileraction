# app/controllers/web/sessions_controller.rb
module Web
  class SessionsController < BaseController
    skip_before_action :authenticate_user!, only: [ :new, :create ]

    def new
      # Acción para mostrar el formulario de inicio de sesión
    end

    def create
      user = User.find_by(email_address: params[:email_address])

      if user&.authenticate(params[:password])
        session[:user_uuid] = user.uuid  # Guarda el UUID del usuario en la sesión
        redirect_after_login(user)

        # Recordar al usuario si la opción "Recordarme" está seleccionada
        if params[:remember_me] == "1"
          cookies.permanent[:user_uuid] = user.uuid
          cookies.permanent[:remember_token] = user.remember_token
        end
      else
        flash.now[:alert] = "Email o contraseña incorrectos"
        # render :new
        redirect_to web_login_path
      end
    end

    def destroy
      reset_session
      cookies.delete(:user_uuid)
      cookies.delete(:remember_token)

      redirect_to root_path(locale: I18n.locale), notice: "Sesión cerrada correctamente", status: :see_other
    end

    private

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
