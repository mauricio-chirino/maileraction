module Web
  class HomeController < Web::BaseController
    def index
      render layout: "application"
    end
  end
end
