class Transaction < ApplicationRecord
  self.primary_key = "uuid"

  # Relación con usuario usando uuid
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true

  # Relación con cuenta de créditos usando uuid
  belongs_to :credit_account, primary_key: "uuid", foreign_key: "credit_account_uuid", optional: true

  # Relación con campaña usando uuid
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  validates :amount, numericality: { greater_than: 0 }
end
