# app/models/bounce.rb

class Bounce < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  after_create :refund_credit_if_prepago

  private

  def refund_credit_if_prepago
    return unless campaign&.usuario_prepago? # Agregado & por si campaign es nil

    account = campaign.user.credit_account
    account.increment!(:credits, 1)

    Rails.logger.info("💸 Crédito devuelto a #{campaign.user.email_address} por rebote de #{email}")
  end
end
