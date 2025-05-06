# app/controllers/web/dashboard/dashboards_controller.rb

module Web
  module Dashboard
    class DashboardsController < Web::BaseController
      require "ostruct"


      def admin
        render layout: "web"
      end

      def campaigns
        render layout: "web"
      end

      def prepaid
        render layout: "web"
      end

      # web/dashboard/dashboards_controller.rb
      def campaign_preview
        render layout: false
      end

      def update_campaign
        @campaign = Campaign.find(params[:id])
        if @campaign.update(campaign_params)
          @scheduled_campaigns = Campaign.where(status: "scheduled").order(:send_at)
          respond_to do |format|
            format.turbo_stream
            format.html { redirect_to web_dashboard_dashboard_path(section: "campaign_scheduled"), notice: "Campaña actualizada." }
          end
        else
          render turbo_stream: turbo_stream.replace("campaign_form", partial: "layouts/shared/campaigns/form", locals: { campaign: @campaign })
        end
      end


      def edit_modal
        @campaign = Campaign.find(params[:id])
        render partial: "layouts/shared/campaigns/edit_modal", layout: false
      end

      def scheduled
        @scheduled_campaigns = Campaign.where(status: "scheduled").order(send_at: :asc)

        respond_to do |format|
          format.turbo_stream
          format.html { render layout: false }
        end
      end


      def cancel
        @campaign = Campaign.find(params[:id])
        @campaign.update(status: "cancelled")

        @scheduled_campaigns = Campaign.where(status: "scheduled")

        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to some_path, notice: "Campaña cancelada." }
        end
      end



      def default
        @campaign_stats = OpenStruct.new(
          total_campaigns: 24,
          total_conversions: 1050,
          total_revenue: "$12,340"
        )


        @scheduled_campaigns = Campaign.where(status: "scheduled").order(send_at: :asc)
        render layout: "web"
      end




      def sent
        @sent_campaigns = Campaign.where(status: "sent").includes(:campaign_emails).order(updated_at: :desc)

        respond_to do |format|
          format.turbo_stream
          format.html { render layout: false }
        end
      end




      private

      def campaign_params
        params.require(:campaign).permit(:send_at, :time_zone)
      end
    end
  end
end
