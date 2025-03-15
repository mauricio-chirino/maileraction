class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy



  has_many :campaigns


  has_one :credit_account
  has_many :transactions


  # belongs_to :role, optional: true
  belongs_to :plan, optional: true

  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  enum :role, [ :admin, :campaign_manager, :designer, :analyst, :user, :collaborator, :observer ], default: :user



  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
