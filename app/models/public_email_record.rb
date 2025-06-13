class PublicEmailRecord < ApplicationRecord
self.primary_key = "uuid"
  belongs_to :industry


  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :company_name, :website, :country, presence: true




  enum :status, [ :unverified, :verified, :rejected ]




  scope :by_industry, ->(industry) { where(industry: industry) }
  scope :by_city, ->(city) { where(city: city) }
end
