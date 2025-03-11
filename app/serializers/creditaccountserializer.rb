class CreditAccountSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :available_credit
end
