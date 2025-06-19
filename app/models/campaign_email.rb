# app/models/campaign_email.rb
class CampaignEmail < ApplicationRecord
  self.primary_key = "uuid"

  # Relaciona por UUID si la tabla ya tiene campaign_uuid y email_record_uuid:
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true

  # Si tu tabla solo tiene los campos viejos (campaign_id, email_record_id), deja así:
  # belongs_to :campaign
  # belongs_to :email_record
end
