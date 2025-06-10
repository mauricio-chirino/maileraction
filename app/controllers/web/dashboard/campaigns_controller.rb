# === app/controllers/web/dashboard/campaigns_controller.rb ===
module Web
  module Dashboard
    class CampaignsController < Web::BaseController
      before_action :authenticate_user!
      before_action :set_campaign_and_blocks, only: [ :default, :show, :edit ]
      layout "dashboard"

      def index
        # TODO: Mostrar campañas del usuario autenticado
      end

      def edit
        @campaign = Campaign.find(params[:id])
        @email_blocks = @campaign.email_blocks.order(:position).to_a
        @show_demo = @email_blocks.empty? && !@campaign.canvas_cleared?
        render layout: "dashboard"
      end

      def update
        @campaign = Campaign.find(params[:id])
        if @campaign.update(campaign_params)
          redirect_to web_dashboard_dashboard_path(section: "campaign_scheduled"), notice: "Campaña reprogramada"
        else
          render :edit, status: :unprocessable_entity
        end
      end


      def add_block
        @campaign = Campaign.find(params[:id])
        # Aquí agregas el bloque según los params recibidos
        # Ejemplo básico:
        # @campaign.email_blocks.create(block_type: params[:block_type], ...otros params...)

        # IMPORTANTE: Si el canvas estaba marcado como limpiado, lo restauramos
        @campaign.update(canvas_cleared: false) if @campaign.canvas_cleared?

        # Redirige o responde con Turbo/JS según tu flujo
        # Ejemplo:
        # redirect_to web_dashboard_dashboard_path(section: "campaign_create", id: @campaign.id)
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
        @campaign = Campaign.find(params[:id])
        @campaign.email_blocks.destroy_all
        @campaign.update(canvas_cleared: true)
        # Redirige o responde con Turbo/JS según tu flujo
        redirect_to web_dashboard_dashboard_path(section: "campaign_create", id: @campaign.id)
      end




      def cancel
        @campaign = Campaign.find(params[:id])
        @campaign.update(status: "cancelled")
        redirect_to web_dashboard_dashboard_path(section: "campaign_scheduled"), notice: "Campaña cancelada"
      end

      def show
        set_campaign_and_blocks
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




      def apply_template
        @campaign = Campaign.find(params[:id])
        @template = Template.find(params[:template_id])

        # Solo si no tiene bloques todavía
        if @campaign.email_blocks.empty?
          @template.template_blocks.order(:position).each do |tb|
            @campaign.email_blocks.create!(
              block_type: tb.block_type,
              html_content: tb.html_content,
              settings: tb.settings,
              position: tb.position,
              user_id: current_user.id
            )
          end
        end
        redirect_to edit_campaign_path(@campaign)
      end








      private

      def set_campaign_and_blocks
        @campaign = Campaign.find(params[:id])
        @email_blocks = @campaign.email_blocks.order(:position).to_a
        @show_demo = @email_blocks.empty? && !@campaign.canvas_cleared?
      end
    end
  end
end
