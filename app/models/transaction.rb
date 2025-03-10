class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :credit_account

  validates :amount, numericality: { greater_than: 0 }
end
