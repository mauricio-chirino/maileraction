class HomeController < ApplicationController
  # Opción: puedes omitir autenticación en el home API
  skip_before_action :authenticate_user_with_jwt!, only: [ :index ]

  def index
    render json: { message: "Bienvenido a MailerAction API", version: "1.0" }
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
