class CampaignSerializer < ActiveModel::Serializer
  attributes :uuid, :user_uuid, :industry_uuid, :email_limit, :status, :created_at,
             :subject, :body, :template_uuid, :template_name, :template_content_html

  def template_name
    object.template&.name
  end

  def template_content_html
    object.template&.content_html
  end
end
