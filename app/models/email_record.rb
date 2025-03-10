class EmailRecord < ApplicationRecord
  belongs_to :industry
  has_many :email_logs
  has_many :bounces
  has_many :campaign_emails
  has_many :campaigns, through: :campaign_emails

  validates :email, presence: true, uniqueness: true
end
