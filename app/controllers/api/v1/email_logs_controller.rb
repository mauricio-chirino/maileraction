module Api
  module V1
    class EmailLogsController < ApplicationController
      def index
        email_logs = policy_scope(EmailLog).joins(:campaign)
                          .where(campaigns: { user_uuid: current_user.uuid })
                          .order(created_at: :desc)
        render json: email_logs, each_serializer: EmailLogSerializer
      end

      def show
        email_log = EmailLog.find_by!(uuid: params[:id])
        authorize email_log
        render json: email_log, serializer: EmailLogSerializer
      end
    end
  end
end
