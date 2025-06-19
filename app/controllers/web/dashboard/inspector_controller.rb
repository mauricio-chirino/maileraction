# app/controllers/web/dashboard/inspector_controller.rb
module Web
  module Dashboard
    class InspectorController < Web::BaseController
       layout false

      def show_property
        category = params[:category]
        block_type = params[:block_type]

        partial_path = "web/dashboard/campaigns/shared/sidebar_blocks/#{category}/properties/#{block_type}"

        if lookup_context.exists?(partial_path, [], true)
          render partial: partial_path
        else
          render html: "<div class='p-3 text-muted'>No properties for this block yet.</div>".html_safe
        end
      end
    end
  end
end
