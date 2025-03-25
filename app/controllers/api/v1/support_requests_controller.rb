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
        params.require(:support_request).permit(:message, :category)
      end
    end
  end
end
