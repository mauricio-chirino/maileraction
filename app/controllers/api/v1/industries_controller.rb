module Api
  module V1
    class IndustriesController < ApplicationController
      before_action :authenticate_user!

      def index
        industries = Industry.select(:id, :name, :email_count)
        render json: industries
      end
    end
  end
end
