# app/models/bounce.rb
self.primary_key = "uuid"
class Bounce < ApplicationRecord
  belongs_to :email_record
  belongs_to :campaign, optional: true # opcional por los registros antiguos



  after_create :refund_credit_if_prepago

  private

  def refund_credit_if_prepago
    return unless campaign.usuario_prepago?

    account = campaign.user.credit_account
    account.increment!(:credits, 1)

    Rails.logger.info("💸 Crédito devuelto a #{campaign.user.email_address} por rebote de #{email}")
  end
end
