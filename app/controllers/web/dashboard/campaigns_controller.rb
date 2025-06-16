module Web
  module Dashboard
    class CampaignsController < Web::BaseController
      before_action :authenticate_user!
      before_action :set_campaign_and_blocks, only: [ :default, :show, :edit ]
      layout "dashboard"

      def index
        # Muestra solo campañas del usuario autenticado usando UUID
        @campaigns = Campaign.where(user_uuid: current_user.uuid)
      end

      def edit
        @campaign = Campaign.find_by!(uuid: params[:id])
        @email_blocks = @campaign.email_blocks.order(:position).to_a
        @show_demo = @email_blocks.empty? && !@campaign.canvas_cleared?
        render layout: "dashboard"
      end

      def update
        @campaign = Campaign.find_by!(uuid: params[:id])
        if @campaign.update(campaign_params)
          redirect_to web_dashboard_dashboard_path(section: "campaign_scheduled"), notice: "Campaña reprogramada"
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def add_block
        @campaign = Campaign.find_by!(uuid: params[:id])
        # Ejemplo básico:
        # @campaign.email_blocks.create(block_type: params[:block_type], ...otros params..., user_uuid: current_user.uuid)
        @campaign.update(canvas_cleared: false) if @campaign.canvas_cleared?
        # Redirige o responde con Turbo/JS según tu flujo
      end

      def block_html
        block_type = params[:block_type] # ej: "hero-basic"
        category, partial = block_type.split("-", 2)
        partial_path = "web/dashboard/campaigns/shared/sidebar_blocks/#{category}/#{category}_#{partial}"
        if lookup_context.exists?(partial_path, [], true)
          render partial: partial_path, formats: [ :html ], layout: false
        else
          render html: "<div>Bloque no disponible aún</div>".html_safe, status: 404
        end
      end

      def default
        set_campaign_and_blocks
      end

      def clear_canvas
        @campaign = Campaign.find_by!(uuid: params[:id])
        @campaign.email_blocks.destroy_all
        @campaign.update(canvas_cleared: true)
        redirect_to web_dashboard_dashboard_path(section: "campaign_create", id: @campaign.uuid)
      end

      def cancel
        @campaign = Campaign.find_by!(uuid: params[:id])
        @campaign.update(status: "cancelled")
        redirect_to web_dashboard_dashboard_path(section: "campaign_scheduled"), notice: "Campaña cancelada"
      end

      def show
        set_campaign_and_blocks
      end

      def statistics
        # Ajusta tus estadísticas aquí según necesites
        @campaign_stats = {
          sent_count: Campaign.where(status: "sent").count,
          opens_count: EmailLog.where(event: "open").count,
          clicks_count: EmailLog.where(event: "click").count,
          bounces_count: Bounce.count,
          cancelled_count: Campaign.where(status: "cancelled").count
        }
        render layout: false
      end

      def apply_template
        @campaign = Campaign.find_by!(uuid: params[:id])
        @template = Template.find_by!(uuid: params[:template_id])

        # Solo si no tiene bloques todavía
        if @campaign.email_blocks.empty?
          @template.template_blocks.order(:position).each do |tb|
            @campaign.email_blocks.create!(
              block_type: tb.block_type,
              html_content: tb.html_content,
              settings: tb.settings,
              position: tb.position,
              user_uuid: current_user.uuid
            )
          end
        end
        redirect_to edit_web_dashboard_campaign_path(@campaign)
      end

      private

      def set_campaign_and_blocks
        @campaign = Campaign.find_by!(uuid: params[:id])
        @email_blocks = @campaign.email_blocks.order(:position).to_a
        @show_demo = @email_blocks.empty? && !@campaign.canvas_cleared?
      end

      def campaign_params
        params.require(:campaign).permit(
          :name, :subject, :body, :email_limit, :status, :template_uuid, :industry_uuid, :send_at
        )
      end
    end
  end
end
