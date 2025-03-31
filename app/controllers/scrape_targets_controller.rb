module Api
  module V1
    class ScrapeTargetsController < ApplicationController
      before_action :authenticate_user!

      def create
        target = ScrapeTarget.find_or_create_by(url: params[:url]) do |t|
          t.status = :pending
        end

        render json: { id: target.id, url: target.url, status: target.status }, status: :created
      end
    end
  end
end
