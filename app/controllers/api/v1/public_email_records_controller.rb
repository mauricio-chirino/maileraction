# app/controllers/api/v1/public_email_records_controller.rb
module Api
  module V1
    class PublicEmailRecordsController < ApplicationController
      before_action :authenticate_user!

      def index
        records = policy_scope(PublicEmailRecord)

        # ✅ Filtro por status
        if params[:status].present?
          records = records.where(status: params[:status])
        else
          records = records.where(status: "valid")
        end

        # ✅ Filtro por industry
        if params[:industry_id].present?
          records = records.where(industry_id: params[:industry_id])
        elsif params[:industry].present?
          industry = Industry.find_by(name: params[:industry])
          records = records.where(industry_id: industry.id) if industry
        end

        # ✅ Filtro por ciudad
        if params[:city].present?
          records = records.where(city: params[:city])
        end

        # ✅ Paginación
        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || 100).to_i
        records = records.offset((page - 1) * per_page).limit(per_page)

        # ✅ Render con industria incluida
        render json: records, include: { industry: { only: [ :id, :name, :name_en ] } }
      end





      def show
        record = PublicEmailRecord.find(params[:id])
        render json: record, serializer: PublicEmailRecordSerializer
      end




      def search
        industry = Industry.find_by(name: params[:industry])
        if industry
          record = PublicEmailRecord.where(industry: industry).limit(params[:limit] || 100)
          render json: record, serializer: PublicEmailRecordSerializer
        else
          render json: { error: "Industria no encontrada" }, status: :not_found
        end
      end
    end
  end
end
