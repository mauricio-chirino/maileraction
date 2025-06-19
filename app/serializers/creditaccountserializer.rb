class CreditAccountSerializer < ActiveModel::Serializer
  attributes :uuid, :user_uuid, :available_credit

  belongs_to :plan, serializer: ::PlanSerializer

  has_many :transactions, serializer: ::TransactionSerializer do
    object.transactions.order(created_at: :desc).limit(5)
  end
end
