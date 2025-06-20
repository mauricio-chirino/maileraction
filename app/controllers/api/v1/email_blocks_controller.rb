# app/controllers/api/v1/email_blocks_controller.rb
# app/controllers/api/v1/email_blocks_controller.rb
module Api
  module V1
    class EmailBlocksController < ApplicationController
      before_action :authenticate_user_with_jwt!
      before_action :set_campaign

      def index
        authorize @campaign, :show?
        blocks = @campaign.email_blocks.order(:position)
        render json: blocks
      end

      def show
        block = @campaign.email_blocks.find_by!(uuid: params[:uuid])
        authorize block, :show?
        render json: block
      end

      def create
        authorize @campaign, :update?
        block = @campaign.email_blocks.create!(
          block_params.merge(user_uuid: current_user.uuid)
        )
        render json: block, status: :created
      end

      def update
        block = @campaign.email_blocks.find_by!(uuid: params[:uuid])
        authorize block, :update?
        block.update!(block_params)
        render json: block
      end

      def destroy
        Rails.logger.info "[DEBUG] UUID recibido: #{params[:uuid]}, Campaign UUID: #{@campaign.uuid}"
        block = @campaign.email_blocks.find_by!(uuid: params[:uuid])
        authorize block, :destroy?
        block.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find_by!(uuid: params[:campaign_uuid])
      end

      def block_params
        params.require(:email_block).permit(
          :block_type, :position, :html_content, :block_template_uuid
        )
      end
    end
  end
end
