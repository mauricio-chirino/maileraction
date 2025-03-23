module Api
  module V1
    class TemplatesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_template, only: [ :show, :update, :destroy ]
      after_action :verify_authorized

      # GET /templates
      def index
        @templates = Template.where("public = ? OR user_id = ?", true, current_user.id)
        authorize Template
        render json: @templates
      end

      # GET /templates/:id
      def show
        authorize @template
        render json: @template
      end

      # POST /templates
      def create
        @template = current_user.templates.build(template_params)
        authorize @template

        if @template.save
          render json: @template, status: :created
        else
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /templates/:id
      def update
        authorize @template

        if @template.update(template_params)
          render json: @template
        else
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /templates/:id
      def destroy
        authorize @template
        @template.destroy
        head :no_content
      end

      private

      def set_template
        @template = Template.find(params[:id])
      end

      def template_params
        params.require(:template).permit(:name, :content, :public)
      end
    end
  end
end
