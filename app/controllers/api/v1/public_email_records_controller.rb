module Api
  module V1
    class PublicEmailRecordsController < ApplicationController
      before_action :authenticate_user!

      def index
        records = PublicEmailRecord.includes(:industry).order(created_at: :desc)

        if params[:industry_id].present?
          records = records.where(industry_id: params[:industry_id])
        elsif params[:industry].present?
          industry = Industry.find_by(name: params[:industry])
          records = records.where(industry_id: industry.id) if industry
        end

        if params[:city].present?
          records = records.where(city: params[:city])
        end

        render json: records, include: { industry: { only: [ :id, :name, :name_en ] } }
      end

      def show
        record = PublicEmailRecord.find(params[:id])
        render json: record
      end

      def search
        records = PublicEmailRecord.where(industry: params[:industry]).limit(params[:limit] || 10)
        render json: records
      end
    end
  end
end
