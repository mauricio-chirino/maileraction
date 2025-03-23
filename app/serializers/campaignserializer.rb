class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :industry_id, :email_limit, :status, :created_at,
             :subject, :body, :template_id, :template_name, :template_content

  def template_name
    object.template&.name
  end

  def template_content
    object.template&.content
  end
end
