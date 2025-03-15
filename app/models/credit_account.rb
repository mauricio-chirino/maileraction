class CreditAccount < ApplicationRecord
  belongs_to :user
  has_one :plan, through: :user  # si el plan está en el usuario
  has_many :transactions
end
