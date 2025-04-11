module Web
  class BaseController < ActionController::Base
    skip_forgery_protection if: -> { request.format.json? }

    include ActionController::Cookies
    include ActionController::Helpers
    include ActionController::Flash
  end
end
