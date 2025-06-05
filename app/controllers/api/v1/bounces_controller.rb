module Api
  module V1
    class BouncesController < ApplicationController
      # before_action :authenticate_user!
      before_action :authenticate_jwt_user!

      def index
        bounces = Bounce.joins(email_record: :campaign)
                        .where(campaigns: { user_id: current_user.id })

        render json: bounces, each_serializer: BounceSerializer
      end

      def show
        bounce = Bounce.find(params[:id])
        authorize bounce
        render json: bounce, serializer: BounceSerializer
      end
    end
  end
end
