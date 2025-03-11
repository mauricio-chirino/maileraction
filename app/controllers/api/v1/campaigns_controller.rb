module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :authenticate_user!

      def index
        #  Muestra todas las campañas del usuario actual (gracias a current_user).
        render json: current_user.campaigns
      end

      def show
        # Muestra los detalles de una campaña específica, siempre que pertenezca al usuario autenticado.
        campaign = current_user.campaigns.find(params[:id])
        render json: campaign
      end

      # Permite crear una nueva campaña vinculada al usuario.
      # Si se guarda correctamente, devuelve la campaña y el status 201 Created.
      # Si hay errores, devuelve los errores y 422.
      def create
        campaign = current_user.campaigns.new(campaign_params)
        if campaign.save
          render json: campaign, status: :created
        else
          render json: { errors: campaign.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # Permite modificar una campaña existente del usuario. Si no la encuentra, lanza error.
      # Si se actualiza, responde con el JSON actualizado.
      # Si falla, devuelve errores.
      def update
        campaign = current_user.campaigns.find(params[:id])
        if campaign.update(campaign_params)
          render json: campaign
        else
          render json: { errors: campaign.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # Elimina una campaña del usuario.
      # Devuelve un 204 No Content si se elimina correctamente (sin body).
      def destroy
        campaign = current_user.campaigns.find(params[:id])
        campaign.destroy
        head :no_content
      end

      # Este método filtra los parámetros permitidos al crear o actualizar campañas.
      # Solo permite:
      # industry_id: rubro seleccionado
      # email_limit: límite de correos a enviar
      # status: estado de la campaña (ej: "draft", "scheduled", "sent")
      private

      def campaign_params
        params.require(:campaign).permit(:industry_id, :email_limit, :status)
      end
    end
  end
end
