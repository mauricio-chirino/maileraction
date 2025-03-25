# SupportRequestsController handles the creation of support requests.
# It ensures that the user is authenticated before allowing access to the create action.
#
# Actions:
# - create: Creates a new support request for the current user. If the request is successfully saved,
#           it triggers an AdminNotifierJob to notify the admin and returns the created support request as JSON.
#           If the request is not saved, it returns the validation errors as JSON.
#
# Private Methods:
# - support_request_params: Permits only the allowed parameters for a support request.
#
# Before Actions:
# - authenticate_user!: Ensures that the user is authenticated before accessing any actions in this controller.
# - authorize @support_request: Ensures that the current user is authorized to create a support request.
# - AdminNotifierJob.perform_later: Triggers the AdminNotifierJob to notify the admin of the new support request.
# - render json: Renders the response as JSON.
#
module Api
  module V1
    class SupportRequestsController < ApplicationController
      before_action :authenticate_user!

      def create
        @support_request = current_user.support_requests.build(support_request_params)
        authorize @support_request

        if @support_request.save
          AdminNotifierJob.perform_later("📬 Nuevo soporte de #{current_user.email_address}: #{@support_request.message}")
          render json: @support_request, status: :created
        else
          render json: { errors: @support_request.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def support_request_params
        params.require(:support_request).permit(:message, :category, :priority, :source)
      end
    end
  end
end
