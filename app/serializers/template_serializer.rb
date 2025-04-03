class TemplateSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :subject,
             :content_html,
             :shared,
             :user_id,
             :created_at,
             :updated_at

  # Incluye información del usuario solo si la plantilla está marcada como compartida
  belongs_to :user, if: -> { object.shared? }
end
