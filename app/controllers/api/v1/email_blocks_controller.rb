# app/controllers/api/v1/email_blocks_controller.rb
module Api
  module V1
    class EmailBlocksController < ApplicationController
      # before_action :authenticate_user!

      before_action :set_campaign

      def index
        authorize @campaign, :show?
        blocks = @campaign.email_blocks.order(:position)
        render json: blocks
      end

      def create
        authorize @campaign, :update?
        Rails.logger.info "BLOCK PARAMS: #{block_params.inspect}"
        block = @campaign.email_blocks.create!(
          block_params.merge(user_uuid: current_user.uuid)  # <-- CAMBIO: asignar user_uuid
        )
        render json: block, status: :created
      end

      def update
        block = @campaign.email_blocks.find_by!(uuid: params[:id]) # <-- CAMBIO: buscar por UUID
        authorize block, :update?
        block.update!(block_params)
        render json: block
      end

      def destroy
        block = @campaign.email_blocks.find_by!(uuid: params[:id]) # <-- CAMBIO: buscar por UUID
        authorize block, :destroy?
        block.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find_by!(uuid: params[:campaign_id]) # <-- CAMBIO: buscar por UUID
      end

      def block_params
        params.require(:email_block).permit(
          :block_type,
          :position,
          :html_content,
          :block_template_uuid # <-- Agrega aquí si usas templates
        )
      end
    end
  end
end
