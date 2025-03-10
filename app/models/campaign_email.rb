class CampaignEmail < ApplicationRecord
  belongs_to :campaign
  belongs_to :email_record
end
