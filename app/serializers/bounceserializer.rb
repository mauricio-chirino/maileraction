class BounceSerializer < ActiveModel::Serializer
  attributes :id, :email_record_id, :reason, :bounced_at
end
