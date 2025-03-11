class ApplicationController < ActionController::API
  include UseAuthentication::ControllerMethods
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: "No autorizado" }, status: :forbidden
  end
end
