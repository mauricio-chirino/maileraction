module Api
  module V1
    class IndustriesController < ApplicationController
      before_action :authenticate_user!

      def index
        industries = policy_scope(Industry)
        authorize Industry

        render json: industries, each_serializer: IndustrySerializer
      end

      def email_counts
        authorize Industry, :index?

        result = Industry
          .left_outer_joins(:public_email_records)
          .group("industries.id", "industries.name")
          .select("industries.id AS industry_id, industries.name AS industry_name, COUNT(public_email_records.id) AS email_count")
          .having("COUNT(public_email_records.id) > 0")

        render json: result.map(&:attributes)
      end
    end
  end
end
