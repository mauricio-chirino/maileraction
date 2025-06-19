module Api
  module V1
    class BouncesController < ApplicationController
      def index
        bounces = Bounce.joins(email_record: :campaign)
                        .where(campaigns: { user_uuid: current_user.uuid })
        render json: bounces, each_serializer: BounceSerializer
      end

      def show
        bounce = Bounce.find_by!(uuid: params[:id])
        authorize bounce
        render json: bounce, serializer: BounceSerializer
      end
    end
  end
end
