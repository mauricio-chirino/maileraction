# === app/controllers/web/dashboard/admin_controller.rb ===
module Web
  module Dashboard
    class AdminController < ApplicationController
      before_action :authenticate_user!
      layout "dashboard"

      def index
        # estadísticas globales, usuarios, feedback, etc.
        @users = User.all
        @campaigns = Campaign.all
        @templates = Template.all
        @feedbacks = Feedback.all
      end
    end
  end
end
