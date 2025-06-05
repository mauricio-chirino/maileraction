
#
module Api
  module V1
    class SupportRequestsController < ApplicationController
      # before_action :authenticate_user!
      # before_action :authenticate_jwt_user!
      before_action :set_support_request, only: [ :show, :update ]

      def create
        puts params.inspect  # 👈 agrega esto
        @support_request = current_user.support_requests.build(support_request_params)

        authorize @support_request, :create?

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
