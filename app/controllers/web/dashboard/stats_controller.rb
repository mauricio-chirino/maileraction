# === app/controllers/web/dashboard/stats_controller.rb ===
module Web
  module Dashboard
    class StatsController < Web::BaseController
      before_action :authenticate_user!
      layout "dashboard"

      def index
        # resumen estadístico de campañas propias, ejemplo:
        @my_campaigns = Campaign.where(user_uuid: current_user.uuid)
      end
    end
  end
end
