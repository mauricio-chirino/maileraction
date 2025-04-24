module Web
  class UsersController < BaseController
    before_action :set_user, only: [ :show, :edit, :update ]





    def show
    end

    def edit
      @user = User.find(params[:id])
    end


    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to edit_web_user_path(@user), notice: "Perfil actualizado correctamente"
      else
        render :edit
      end
    end


    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email_address, :avatar)
    end
  end
end
