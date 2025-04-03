# app/controllers/web/home_controller.rb
module Web
  class HomeController < Web::BaseController
    skip_before_action :verify_authenticity_token
    def index; end
  end
end
