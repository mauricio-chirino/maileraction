# === app/controllers/web/dashboard/campaigns_controller.rb ===
module Web
  module Dashboard
    # class CampaignsController < ApplicationController
    class CampaignsController < Web::BaseController
      before_action :authenticate_user!
      layout "dashboard"

      def index
        # campañas del usuario
      end

      def edit
        @campaign = Campaign.find(params[:id])
        render layout: "dashboard"
      end

      def update
        @campaign = Campaign.find(params[:id])
        if @campaign.update(campaign_params)
          redirect_to dashboard_path(section: "campaign_scheduled"), notice: "Campaña reprogramada"
        else
          render :edit, status: :unprocessable_entity
        end
      end



      def cancel
        @campaign = Campaign.find(params[:id])
        @campaign.update(status: "cancelled")
        redirect_to web_dashboard_dashboard_path(section: "campaign_scheduled"), notice: "Campaña cancelada"
      end

      def show
        @campaign = Campaign.find(params[:id])
      end

      def statistics
        @campaign_stats = {
          sent_count: Campaign.where(status: "sent").count,
          opens_count: EmailLog.where(event: "open").count,
          clicks_count: EmailLog.where(event: "click").count,
          bounces_count: Bounce.count,
          cancelled_count: Campaign.where(status: "cancelled").count
        }

        render layout: false
      end

      private

      def campaign_params
        params.require(:campaign).permit(:send_at, :time_zone, :name, :subject, :sender, :html_content)
      end
    end
  end
end
