class CreditAccountSerializer < ActiveModel::Serializer
  attributes :uuid, :available_credit

  # Solo incluye el plan si tienes plan_uuid en credit_accounts,
  # pero normalmente CreditAccount pertenece a User, no a Plan.
  # Si quieres mostrar el plan del usuario, puedes accederlo a través del usuario.

  # belongs_to :plan, serializer: ::PlanSerializer
  # Si CreditAccount pertenece a User:
  belongs_to :user, serializer: ::UserSerializer

  has_many :transactions, serializer: ::TransactionSerializer do
    object.transactions.order(created_at: :desc).limit(5)
  end
end
