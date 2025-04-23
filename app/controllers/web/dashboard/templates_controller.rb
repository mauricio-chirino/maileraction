# === app/controllers/web/dashboard/templates_controller.rb ===
module Web
  module Dashboard
    class TemplatesController < ApplicationController
      before_action :authenticate_user!
      layout "dashboard"

      def index
        # plantillas propias o públicas
      end
    end
  end
end
