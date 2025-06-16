class BounceSerializer < ActiveModel::Serializer
  attributes :uuid, :email_record_uuid, :reason, :bounced_at
end
