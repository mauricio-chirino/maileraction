class EmailRecordSerializer < ActiveModel::Serializer
  attributes :uuid, :email, :company, :website, :industry_uuid
end
