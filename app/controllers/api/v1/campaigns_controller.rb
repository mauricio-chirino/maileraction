module Api
  module V1
    class CampaignsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_campaign, only: [ :show, :update, :destroy, :stats, :send_campaign ]


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


        # Verificación de ownership del template
        if @campaign.template_id.present?
          template = Template.find_by(id: @campaign.template_id)

          if template.nil? || template.user_id != current_user.id
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

        logs = EmailLog.where(campaign_id: @campaign.id)

        total_sent = logs.count
        total_opens = logs.where.not(opened_at: nil).count
        total_clicks = logs.where.not(clicked_at: nil).count
        # total_bounces = Bounce.joins(:email_record).where(email_records: { campaign_id: @campaign.id }).count
        total_bounces = Bounce.where(campaign_id: @campaign.id).count

        open_rate = total_sent > 0 ? ((total_opens.to_f / total_sent) * 100).round(2) : 0
        click_rate = total_sent > 0 ? ((total_clicks.to_f / total_sent) * 100).round(2) : 0
        bounce_rate = total_sent > 0 ? ((total_bounces.to_f / total_sent) * 100).round(2) : 0

        render json: {
          campaign_id: @campaign.id,
          emails_sent: total_sent,
          emails_opened: total_opens,
          emails_clicked: total_clicks,
          emails_bounced: total_bounces,
          open_rate: "#{open_rate}%",
          click_rate: "#{click_rate}%",
          bounce_rate: "#{bounce_rate}%"
        }
      end




      # POST /api/v1/campaigns/:id/send
      def send_campaign
        authorize @campaign, :send?

        if @campaign.status == "completed"
          render json: { error: "La campaña ya fue enviada." }, status: :unprocessable_entity and return
        end

        @campaign.update!(status: "sending")

        Campaigns::SendCampaignJob.perform_later(@campaign.id)

        render json: { message: "Campaña en cola para envío." }
      end







      private

      def set_campaign
        @campaign = Campaign.find(params[:id])
      end

      def campaign_params
        # params.require(:campaign).permit(:industry_id, :email_limit, :status, :subject, :body)
        params.require(:campaign).permit(:industry_id, :email_limit, :status, :subject, :body, :template_id)
      end
    end
  end
end
