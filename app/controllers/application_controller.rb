class ApplicationController < ActionController::API
  around_action :set_time_zone_from_header

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

  def set_time_zone_from_header(&block)
    time_zone = request.headers["Time-Zone"]
    if time_zone.present? && ActiveSupport::TimeZone[time_zone]
      Time.use_zone(time_zone, &block)
    else
      # fallback por defecto
      Time.use_zone("UTC", &block)
    end
  end
end
