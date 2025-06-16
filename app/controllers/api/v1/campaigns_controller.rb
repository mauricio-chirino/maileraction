# app/controllers/api/v1/campaigns_controller.rb
module Api
  module V1
    class CampaignsController < ApplicationController
      # before_action :authenticate_user!
      # before_action :authenticate_jwt_user!
      before_action :set_campaign, only: [ :show, :update, :destroy, :stats, :send_campaign, :cancel ]

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
        # CAMBIO: build campaign con user_uuid (no user_id)
        @campaign = current_user.campaigns.build(campaign_params.merge(user_uuid: current_user.uuid))

        if @campaign.template_uuid.present?
          template = Template.find_by(uuid: @campaign.template_uuid)
          if template.nil? || template.user_uuid != current_user.uuid
            render json: { error: "No autorizado para usar esta plantilla" }, status: :forbidden and return
          end
        end

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
        stats = CampaignStatisticsService.new(@campaign).call
        render json: {
          campaign_id: @campaign.uuid,  # <-- CAMBIO
          emails_sent: stats[:emails_sent],
          emails_opened: stats[:emails_opened],
          emails_clicked: stats[:emails_clicked],
          emails_bounced: stats[:emails_bounced],
          open_rate: "#{stats[:open_rate]}%",
          click_rate: "#{stats[:click_rate]}%",
          bounce_rate: "#{stats[:bounce_rate]}%"
        }
      end

      # POST /api/v1/campaigns/:id/send_campaign
      def send_campaign
        authorize @campaign, :send?
        if @campaign.status.in?(%w[sending completed])
          render json: { error: "La campaña ya está en proceso o fue enviada." }, status: :unprocessable_entity and return
        end
        @campaign.update!(status: "sending")
        Campaigns::SendCampaignJob.perform_later(@campaign.uuid) # <-- CAMBIO: usa UUID
        render json: { message: "Campaña en cola para envío." }
      end

      # POST /api/v1/campaigns/:id/cancel
      def cancel
        authorize @campaign, :cancel?
        if @campaign.status != "sending"
          render json: { error: "Solo se pueden cancelar campañas en estado 'sending'." }, status: :unprocessable_entity and return
        end
        @campaign.update!(status: "cancelled")
        Notification.create!(
          user_uuid: @campaign.user_uuid, # <-- CAMBIO: usa UUID
          title: "🚫 Campaña cancelada",
          body: "La campaña \"#{@campaign.subject}\" fue cancelada antes de ser enviada."
        )
        render json: { message: "Campaña cancelada exitosamente." }, status: :ok
      end

      # GET /api/v1/campaigns/monthly_summary
      def monthly_summary
        authorize Campaign, :index?
        campaigns = policy_scope(Campaign).where("created_at >= ?", 1.month.ago.beginning_of_month)
        summaries = campaigns.map do |campaign|
          stats = CampaignStatisticsService.new(campaign).call
          {
            campaign_id: campaign.uuid,  # <-- CAMBIO
            subject: campaign.subject,
            created_at: campaign.created_at,
            industry_uuid: campaign.industry_uuid, # <-- CAMBIO
            emails_sent: stats[:emails_sent],
            emails_opened: stats[:emails_opened],
            emails_clicked: stats[:emails_clicked],
            emails_bounced: stats[:emails_bounced],
            open_rate: stats[:open_rate],
            click_rate: stats[:click_rate],
            bounce_rate: stats[:bounce_rate]
          }
        end
        render json: summaries
      end

      private

      def set_campaign
        @campaign = Campaign.find_by!(uuid: params[:id]) # <-- CAMBIO: busca por uuid
      end

      def campaign_params
        params.require(:campaign).permit(
          :industry_uuid, :email_limit, :status, :subject, :body, :template_uuid
        ) # <-- CAMBIO: solo UUIDs
      end
    end
  end
end
