class EmailRecordSerializer < ActiveModel::Serializer
  attributes :id, :email, :compani, :website, :industry_id
end
