class CampaignSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :industry_id, :email_limit, :status, :created_at
end
