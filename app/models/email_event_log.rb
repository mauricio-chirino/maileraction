class EmailEventLog < ApplicationRecord
  self.primary_key = "uuid"
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  validates :email, presence: true
  validates :event_type, presence: true
end
