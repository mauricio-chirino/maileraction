class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :industry_id, :email_limit, :status, :created_at,
             :subject, :body, :template_id, :template_name, :template_content_html

  def template_name
    object.template&.name
  end

  def template_content_html
    object.template&.content_html
  end
end
