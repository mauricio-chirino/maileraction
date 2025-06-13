class Transaction < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true
  belongs_to :credit_account, optional: true
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  validates :amount, numericality: { greater_than: 0 }
end
