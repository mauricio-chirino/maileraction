# === app/controllers/web/dashboard/campaigns_controller.rb ===
module Web
  module Dashboard
    class CampaignsController < ApplicationController
      before_action :authenticate_user!
      layout "dashboard"

      def index
        # campañas del usuario
      end
    end
  end
end
