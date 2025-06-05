module Api
  module V1
    class ScrapingsController < ApplicationController
      # before_action :authenticate_user!
      before_action :authenticate_jwt_user!

      def create
        url = params[:url]

        if url.blank?
          return render json: { error: "URL es requerida" }, status: :unprocessable_entity
        end

        ScrapeEmailJob.perform_later(url)
        render json: { message: "Scraping encolado con éxito para: #{url}" }, status: :accepted
      end
    end
  end
end
