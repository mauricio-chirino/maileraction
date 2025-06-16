class CampaignSerializer < ActiveModel::Serializer
  attributes :uuid, :industry_uuid, :email_limit, :status, :created_at
end
