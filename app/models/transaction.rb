class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :credit_account

  belongs_to :campaign, optional: true

  validates :amount, numericality: { greater_than: 0 }
end
