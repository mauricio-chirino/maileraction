# app/services/rebound_credit_refunder.rb
class ReboundCreditRefunder
  def self.call(campaign_id:, email:)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign&.usuario_prepago?

    email_record = EmailRecord.find_by(email: email)
    return unless email_record

    email_log = EmailLog.find_by(campaign_id: campaign.id, email_record: email_record)
    return if email_log.nil? || email_log.credit_refunded?

    account = campaign.user.credit_account
    account.increment!(:credits, 1)

    email_log.update!(credit_refunded: true)

    Rails.logger.info("💸 Crédito devuelto a #{campaign.user.email_address} por rebote de #{email}")
  end
end
