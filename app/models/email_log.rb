class EmailLog < ApplicationRecord
  belongs_to :campaign
  belongs_to :email_record

  validates :status, inclusion: { in: %w[success error], message: "%{value} no es válido" }
end
