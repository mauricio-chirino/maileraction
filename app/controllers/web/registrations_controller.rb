# app/controllers/web/registrations_controller.rb
module Web
  class RegistrationsController < BaseController
    skip_before_action :authenticate_user!, only: [ :new, :create ]
    layout "application"

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      @user.generate_remember_token_value

      if @user.save
        redirect_to root_path, notice: "¡Registro exitoso! Ahora puedes iniciar sesión."
      else
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation, :company, :name)
    end
  end
end
