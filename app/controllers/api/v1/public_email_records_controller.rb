# app/controllers/api/v1/public_email_records_controller.rb
module Api
  module V1
    class PublicEmailRecordsController < ApplicationController
      def index
        records = policy_scope(PublicEmailRecord)
        if params[:status].present?
          records = records.where(status: params[:status])
        end
        if params[:industry_uuid].present?
          records = records.where(industry_uuid: params[:industry_uuid])
        elsif params[:industry].present?
          industry = Industry.find_by(name: params[:industry])
          records = records.where(industry_uuid: industry.uuid) if industry
        end
        if params[:city].present?
          records = records.where(city: params[:city])
        end
        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || 100).to_i
        records = records.offset((page - 1) * per_page).limit(per_page)
        render json: records, include: { industry: { only: [ :uuid, :name, :name_en ] } }
      end

      def show
        record = PublicEmailRecord.find_by!(uuid: params[:id])
        render json: record, serializer: PublicEmailRecordSerializer
      end

      def search
        industry = Industry.find_by(name: params[:industry])
        if industry
          record = PublicEmailRecord.where(industry_uuid: industry.uuid).limit(params[:limit] || 100)
          render json: record, serializer: PublicEmailRecordSerializer
        else
          render json: { error: "Industria no encontrada" }, status: :not_found
        end
      end
    end
  end
end
