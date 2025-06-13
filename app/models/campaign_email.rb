class CampaignEmail < ApplicationRecord
self.primary_key = "uuid"
  belongs_to :campaign
  belongs_to :email_record
end
