# app/controllers/api/v1/email_blocks_controller.rb
module Api
  module V1
    class EmailBlocksController < ApplicationController
      before_action :authenticate_user!
      before_action :set_campaign

      def index
        authorize @campaign, :show?
        blocks = @campaign.email_blocks.order(:position)
        render json: blocks
      end

      def create
        authorize @campaign, :update?
        block = @campaign.email_blocks.create!(block_params)
        render json: block, status: :created
      end

      def update
        block = @campaign.email_blocks.find(params[:id])
        authorize block, :update?
        block.update!(block_params)
        render json: block
      end

      def destroy
        block = @campaign.email_blocks.find(params[:id])
        authorize block, :destroy?
        block.destroy
        head :no_content
      end

      private

      def set_campaign
        @campaign = Campaign.find(params[:campaign_id])
      end

      def block_params
        params.require(:email_block).permit(:block_type, :category, :position, :content)
      end
    end
  end
end
