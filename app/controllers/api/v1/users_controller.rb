# controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
  before_action :require_authentication

  def me
    render json: current_user, serializer: UserSerializer
  end

  private

  def reject_unallowed_methods
    unless request.get?
      head :method_not_allowed
    end
  end
end
