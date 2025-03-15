class CreditConsumeResponseSerializer < ActiveModel::Serializer
  attributes :message, :remaining_credits
  has_one :transaction, serializer: TransactionSerializer

  def message
    "Créditos consumidos correctamente."
  end

  def remaining_credits
    object[:remaining_credits]
  end

  def transaction
    object[:transaction]
  end
end
