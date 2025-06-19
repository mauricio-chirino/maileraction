class PublicEmailRecord < ApplicationRecord
  self.primary_key = "uuid"
  belongs_to :industry, primary_key: "uuid", foreign_key: "industry_uuid", optional: true

  # El resto igual
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :company_name, :website, :country, presence: true

  enum :status, [ :unverified, :verified, :rejected ]
  scope :by_industry, ->(industry) { where(industry: industry) }
  scope :by_city, ->(city) { where(city: city) }
end
