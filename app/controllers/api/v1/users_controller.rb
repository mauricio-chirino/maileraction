# controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :require_authentication



  # Acción para registrar un nuevo usuario
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "Usuario registrado correctamente", user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end



  # Acción para obtener el usuario actual
  def me
    render json: current_user, serializer: UserSerializer
  end

  private

  # Strong parameters para proteger los datos del usuario
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # Para evitar métodos no permitidos
  def reject_unallowed_methods
    unless request.get?
      head :method_not_allowed
    end
  end
end
