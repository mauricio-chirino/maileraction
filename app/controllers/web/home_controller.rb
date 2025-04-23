module Web
  class HomeController < Web::BaseController
    skip_before_action :authenticate_user!, only: [ :index ] # Asegura que el index sea accesible sin autenticación

    def index
      render layout: "application"
    end
  end
end
