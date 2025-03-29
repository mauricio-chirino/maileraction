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
      before_action :set_support_request, only: [ :show, :update ]

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

      def index
        @support_requests = policy_scope(SupportRequest)
        render json: @support_requests
      end

      def show
        authorize @support_request
        render json: @support_request
      end

      def update
        authorize @support_request

        if @support_request.update(support_request_params)
          render json: @support_request
        else
          render json: { errors: @support_request.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_support_request
        @support_request = SupportRequest.find(params[:id])
      end

      def support_request_params
        params.require(:support_request).permit(:message, :category, :priority, :status, :source)
      end
    end
  end
end
