# === app/controllers/web/dashboard/stats_controller.rb ===
module Web
  module Dashboard
    class StatsController < ApplicationController
      before_action :authenticate_user!
      layout "dashboard"

      def index
        # resumen estadístico de campañas propias
      end
    end
  end
end
