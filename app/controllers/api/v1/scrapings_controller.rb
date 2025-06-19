# app/controllers/api/v1/scrapings_controller.rb
module Api
  module V1
    class ScrapingsController < ApplicationController
      def create
        url = params[:url]
        if url.blank?
          render json: { error: "URL es requerida" }, status: :unprocessable_entity and return
        end

        ScrapeEmailJob.perform_later(url)
        render json: { message: "Scraping encolado con éxito para: #{url}" }, status: :accepted
      end
    end
  end
end
