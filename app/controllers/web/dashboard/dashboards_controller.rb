# app/controllers/web/dashboard/dashboards_controller.rb

module Web
  module Dashboard
    class DashboardsController < Web::BaseController
      def admin
        render layout: "web"
      end

      def campaigns
        render layout: "web"
      end

      def prepaid
        render layout: "web"
      end

      def default
        render layout: "web"
      end
    end
  end
end
