# app/controllers/web/dashboard/inspector_controller.rb
module Web
  module Dashboard
    class InspectorController < Web::BaseController
      def show_property
        category = params[:category]
        block_type = params[:block_type]

        partial_path = "web/dashboard/campaigns/shared/sidebar_blocks/#{category}/properties/#{block_type}_property"

        if lookup_context.exists?(partial_path, [], true)
          render partial: partial_path, formats: [ :html ]
        else
          render inline: "<div class='text-muted'>No properties for this block yet.</div>", status: 200
        end
      end
    end
  end
end
