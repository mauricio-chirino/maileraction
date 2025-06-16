class TemplateSerializer < ActiveModel::Serializer
  attributes :uuid,
             :name,
             :subject,
             :content_html,
             :shared,
             :user_uuid,
             :created_at,
             :updated_at

  belongs_to :user, if: -> { object.shared? }, serializer: UserSerializer
end
