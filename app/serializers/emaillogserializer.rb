class EmailLogSerializer < ActiveModel::Serializer
  attributes :uuid, :campaign_uuid, :email_record_uuid, :status, :opened_at, :clicked_at

  belongs_to :campaign, serializer: CampaignSerializer, key: :campaign
  belongs_to :email_record, serializer: EmailRecordSerializer, key: :email_record
end
