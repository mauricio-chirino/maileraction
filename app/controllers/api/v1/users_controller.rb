# controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user_with_jwt!
  before_action :require_authentication

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: "Usuario registrado correctamente", user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def me
    render json: current_user, serializer: UserSerializer
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
