module Api
  module V1
    module Admin
      class IndustriesController < ApplicationController
        # before_action :authenticate_user! # o :authorize_admin!
        before_action :set_industry, only: [ :show, :update, :destroy ]

        # GET /api/v1/admin/industries
        def index
          industries = Industry.all.order(:name)
          render json: industries, each_serializer: IndustrySerializer
        end

        # GET /api/v1/admin/industries/:id
        def show
          render json: @industry, serializer: IndustrySerializer
        end

        # POST /api/v1/admin/industries
        def create
          @industry = Industry.new(industry_params)
          if @industry.save
            render json: @industry, serializer: IndustrySerializer, status: :created
          else
            render json: { errors: @industry.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # PATCH/PUT /api/v1/admin/industries/:id
        def update
          if @industry.update(industry_params)
            render json: @industry, serializer: IndustrySerializer
          else
            render json: { errors: @industry.errors.full_messages }, status: :unprocessable_entity
          end
        end

        # DELETE /api/v1/admin/industries/:id
        def destroy
          @industry.destroy
          head :no_content
        end

        # POST /api/v1/admin/industries/reset_counts
        def reset_counts
          ResetIndustryEmailCountsJob.perform_later
          render json: { message: "Recalculando contadores de emails por industria..." }, status: :accepted
        end

        # GET /api/v1/admin/industries/email_counts
        def email_counts
          result = Industry
            .left_outer_joins(:public_email_records)
            .group("industries.uuid", "industries.name")
            .select("industries.uuid AS industry_uuid, industries.name AS industry_name, COUNT(public_email_records.id) AS email_count")
            .order("industries.name ASC")

          render json: result.map(&:attributes)
        end

        private

        def set_industry
          @industry = Industry.find_by!(uuid: params[:id])
        end

        def industry_params
          params.require(:industry).permit(:name, :name_en)
        end
      end
    end
  end
end
