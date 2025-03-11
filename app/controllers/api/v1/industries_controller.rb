module Api
  module V1
    class IndustriesController < ApplicationController
      before_action :authenticate_user!

      def index
        industries = policy_scope(Industry)
        authorize Industry
        render json: industries
      end
    end
  end
end
