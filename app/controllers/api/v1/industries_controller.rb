# app/controllers/api/v1/industries_controller.rb
module Api
  module V1
    class IndustriesController < ApplicationController
      def index
        industries = policy_scope(Industry)
        authorize Industry
        render json: industries, each_serializer: IndustrySerializer
      end

      def show
        industry = Industry.find_by!(uuid: params[:id])
        authorize industry
        render json: industry, serializer: IndustrySerializer
      end

      # Opción adicional: estadísticas por industria
      def email_counts
        authorize Industry, :index?

        result = Industry
          .left_outer_joins(:public_email_records)
          .group("industries.uuid", "industries.name")
          .select("industries.uuid AS industry_uuid, industries.name AS industry_name, COUNT(public_email_records.id) AS email_count")
          .having("COUNT(public_email_records.id) > 0")

        render json: result.map(&:attributes)
      end
    end
  end
end
