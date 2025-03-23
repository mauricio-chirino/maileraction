class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :industry

  has_many :campaign_emails
  has_many :email_records, through: :campaign_emails
  has_many :email_logs

  has_many :bounces

  validates :email_limit, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[pending sending completed] }

  validates :subject, presence: true
  validates :body, presence: true
end
