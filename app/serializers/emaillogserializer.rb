class EmailLogSerializer < ActiveModel::Serializer
  attributes :id, :campaign_id, :email_record_id, :status, :opened_at, :clicked_at
end
