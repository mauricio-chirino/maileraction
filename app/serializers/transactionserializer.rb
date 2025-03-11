class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :amount, :status, :payment_method, :created_at
end
