class User < ApplicationRecord
  has_secure_password # Habilita autenticación segura con bcrypt

  belongs_to :role, optional: true
  belongs_to :plan, optional: true

  has_many :campaigns
  has_one :credit_account
  has_many :transactions

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  enum :role, [ :admin, :campaign_manager, :designer, :analyst, :user, :collaborator, :observer ], default: :user
end
