# === app/controllers/web/dashboard/templates_controller.rb ===
module Web
  module Dashboard
    class TemplatesController < Web::BaseController
      before_action :authenticate_user!

      def index
        # Puedes cargar ambos: públicos y propios por UUID
        @templates = Template.where(public: true)
        @templates = @templates.or(Template.where(user_uuid: current_user.uuid)) if Template.column_names.include?("user_uuid")
        @templates = @templates.distinct
        @categories = @templates.pluck(:category).uniq.compact
      end

      def show
        @template = Template.find_by!(uuid: params[:id])
      end
    end
  end
end
