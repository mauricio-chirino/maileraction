class EmailLog < ApplicationRecord
  belongs_to :campaign
  belongs_to :email_record

  enum status: { success: "success", error: "error", delivered: "delivered" }

  # Validación personalizada del enum con mensaje explícito
  validates :status, inclusion: {
    in: statuses.keys,
    message: "%{value} no es válido"
  }

  # Scopes para trazabilidad de reembolsos
  scope :refunded, -> { where(credit_refunded: true) }
  scope :not_refunded, -> { where(credit_refunded: false) }

  def refunded?
    credit_refunded
  end
end
