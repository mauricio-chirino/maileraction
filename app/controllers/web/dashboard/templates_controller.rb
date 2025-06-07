# === app/controllers/web/dashboard/templates_controller.rb ===
module Web
  module Dashboard
    class TemplatesController < Web::BaseController
      before_action :authenticate_user!



      def index
        # Cargar templates públicos y propios (si los tienes)
        @templates = Template.where(public: true)
        @templates = @templates.or(Template.where(user_id: current_user.id)) if Template.column_names.include?("user_id")
        @templates = @templates.distinct
        @categories = @templates.pluck(:category).uniq.compact
      end

      def show
        @template = Template.find(params[:id])
      end
    end
  end
end
