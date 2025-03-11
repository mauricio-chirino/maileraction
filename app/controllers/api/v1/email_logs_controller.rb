module Api
  module V1
    class EmailLogsController < ApplicationController
      before_action :authenticate_user!

      def index
        email_logs = policy_scope(EmailLog).joins(:campaign)
                          .where(campaigns: { user_id: current_user.id })
                          .order(created_at: :desc)

        render json: email_logs, each_serializer: EmailLogSerializer
      end

      def show
        email_log = EmailLog.find(params[:id])
        authorize email_log
        render json: email_log, serializer: EmailLogSerializer
      end
    end
  end
end
