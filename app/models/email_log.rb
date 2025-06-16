# app/models/email_log.rb
class EmailLog < ApplicationRecord
  self.primary_key = "uuid"

  def self.statuses
    %w[success error delivered]
  end

  # Asociaciones usando los nuevos UUIDs
  belongs_to :campaign,   primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true

  # Scopes para trazabilidad de reembolsos
  scope :refunded,     -> { where(credit_refunded: true) }
  scope :not_refunded, -> { where(credit_refunded: [ false, nil ]) }

  validates :status, inclusion: { in: statuses }

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
