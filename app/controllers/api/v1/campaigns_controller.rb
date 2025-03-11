module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_campaign, only: [ :show, :update, :destroy, :stats, :send ]

      # GET /api/v1/campaigns
      def index
        @campaigns = policy_scope(Campaign)
        render json: @campaigns, each_serializer: CampaignSerializer
      end

      # GET /api/v1/campaigns/:id
      def show
        authorize @campaign
        render json: @campaign, serializer: CampaignSerializer
      end

      # POST /api/v1/campaigns
      def create
        @campaign = current_user.campaigns.build(campaign_params)
        authorize @campaign

        if @campaign.save
          render json: @campaign, serializer: CampaignSerializer, status: :created
        else
          render json: { errors: @campaign.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /api/v1/campaigns/:id
      def update
        authorize @campaign
        if @campaign.update(campaign_params)
          render json: @campaign, serializer: CampaignSerializer
        else
          render json: { errors: @campaign.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/campaigns/:id
      def destroy
        authorize @campaign
        @campaign.destroy
        head :no_content
      end

      # GET /api/v1/campaigns/:id/stats
      def stats
        authorize @campaign, :stats?
        render json: {
          opens: EmailLog.where(campaign_id: @campaign.id).where.not(opened_at: nil).count,
          clicks: EmailLog.where(campaign_id: @campaign.id).where.not(clicked_at: nil).count,
          bounces: Bounce.joins(:email_record).where(email_records: { campaign_id: @campaign.id }).count
        }
      end

      # POST /api/v1/campaigns/:id/send
      def send
        authorize @campaign, :send?
        # lógica de envío (Solid Queue Job)
        render json: { message: "Campaña en cola para envío." }
      end

      private

      def set_campaign
        @campaign = Campaign.find(params[:id])
      end

      def campaign_params
        params.require(:campaign).permit(:industry_id, :email_limit, :status)
      end
    end
  end
end
