class ApplicationController < ActionController::API
  include Authentication  # 👈 este es el bueno
  include Pundit
  # agrgados************************************
  include ActionController::Cookies
  include ActionController::Helpers

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render json: { error: "No autorizado" }, status: :forbidden
  end
end
