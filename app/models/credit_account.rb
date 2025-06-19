class CreditAccount < ApplicationRecord
  self.primary_key = "uuid"

  # Relación a usuario por UUID (mejor práctica)
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  # Relación a plan vía usuario
  has_one :plan, through: :user

  # Relación a transacciones por UUID
  has_many :transactions, primary_key: "uuid", foreign_key: "credit_account_uuid"

  validates :available_credit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
