module Api
  module V1
    class TemplatesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_template, only: [ :show, :update, :destroy, :preview ]
      after_action :verify_authorized

      # GET /api/v1/templates
      def index
        @templates = policy_scope(Template)
        authorize Template
        render json: @templates, each_serializer: TemplateSerializer
      end

      # GET /api/v1/templates/:id
      def show
        authorize @template
        render json: @template, serializer: TemplateSerializer
      end

      # POST /api/v1/templates
      def create
        @template = current_user.templates.build(template_params)
        authorize @template

        if @template.save
          render json: @template, serializer: TemplateSerializer, status: :created
        else
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/templates/:id
      def update
        authorize @template

        if @template.update(template_params)
          render json: @template, serializer: TemplateSerializer
        else
          render json: { errors: @template.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/templates/:id
      def destroy
        authorize @template
        @template.destroy
        head :no_content
      end

      # GET /api/v1/templates/:id/preview
      # Este método usará el contenido HTML de la plantilla y lo devolverá directamente
      # como una página para ser vista en el navegador.
      def preview
        authorize @template

        html = @template.content.presence || @template.try(:content_html) || "<p>Esta plantilla no tiene contenido.</p>"
        render html: html.html_safe, layout: false
      end



      private

      def set_template
        @template = Template.find(params[:id])
      end

      def template_params
        params.require(:template).permit(:name, :subject, :content_html, :shared)
      end
    end
  end
end
