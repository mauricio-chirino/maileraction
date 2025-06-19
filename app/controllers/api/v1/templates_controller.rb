module Api
  module V1
    class TemplatesController < ApplicationController
      before_action :set_template, only: [ :show, :update, :destroy, :preview ]
      after_action :verify_authorized

      def index
        @templates = policy_scope(Template)
        authorize Template
        render json: @templates, each_serializer: TemplateSerializer
      end

      def show
        authorize @template
        render json: @template, serializer: TemplateSerializer
      end

      def create
        @template = current_user.templates.build(template_params)
        authorize @template
        if @template.save
          render json: @template, serializer: TemplateSerializer, status: :created
        else
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        authorize @template
        if @template.update(template_params)
          render json: @template, serializer: TemplateSerializer
        else
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        authorize @template
        @template.destroy
        head :no_content
      end

      def preview
        authorize @template
        html = @template.content.presence || @template.try(:content_html) || "<p>Esta plantilla no tiene contenido.</p>"
        render html: html.html_safe, layout: false
      end

      private

      def set_template
        @template = Template.find_by!(uuid: params[:id])
      end

      def template_params
        params.require(:template).permit(:name, :subject, :content_html, :shared)
      end
    end
  end
end
