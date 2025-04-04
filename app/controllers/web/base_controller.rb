module Web
  class BaseController < ActionController::Base
    protect_from_forgery with: :exception
    include ActionController::Cookies
    include ActionController::Helpers
  end
end
