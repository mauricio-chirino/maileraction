module Api
  module V1
    class WebhooksController < ApplicationController
      skip_before_action :verify_authenticity_token

      def payment
        # Aquí irá la lógica para procesar pagos y recargar créditos
        # según el servicio de Stripe / MercadoPago
        head :ok
      end
    end
  end
end
