class EmailLog < ApplicationRecord
  self.primary_key = "uuid"
  def self.statuses
    %w[success error delivered]
  end


  belongs_to :campaign
  belongs_to :email_record

  # Scopes para trazabilidad de reembolsos
  scope :refunded,     -> { where(credit_refunded: true) }
  scope :not_refunded, -> { where(credit_refunded: [ false, nil ]) }

  validates :status, inclusion: { in: statuses }

  # Validación (opcional si decidís activarla)
  # validates :status, inclusion: { in: ->(_) { statuses.keys }, message: "%{value} no es válido" }
  #
  #
  # Métodos de conveniencia para manejar estados
  def success?
    status == "success"
  end

  def error?
    status == "error"
  end

  def delivered?
    status == "delivered"
  end

  def refunded?
    credit_refunded
  end
end
