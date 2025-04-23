class HomeController < ApplicationController
  skip_before_action :require_authentication

  def index
    render layout: "application"
  end
end



# esto debe ser verificado para el ingreso
# # class Api::V1::HomeController < ApplicationController
# #   before_action :authenticate_user!  # Si todas las rutas requieren autenticación

# #   def index
# #     # Lógica para la respuesta de la API
# #     render json: { message: 'API Home' }
# #   end
# #end
