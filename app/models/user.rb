# The User model represents a user in the application.
# It includes authentication, associations, validations, and normalizations.
#
# Associations:
# - has_secure_password: Adds methods to set and authenticate against a BCrypt password.
# - has_many :sessions: A user can have many sessions, which are destroyed if the user is destroyed.
# - has_many :campaigns: A user can have many campaigns.
# - has_many :templates: A user can have many templates.
# - has_one :credit_account: A user has one credit account.
# - has_many :transactions: A user can have many transactions.
# - has_many :support_requests: A user can have many support requests.
# - belongs_to :plan: A user optionally belongs to a plan.
#
# Validations:
# - email_address: Must be present and unique.
# - password: Must be at least 6 characters long if present.
#
# Enums:
# - role: Defines user roles with default set to :user. Possible roles are:
#   :admin, :campaign_manager, :designer, :analyst, :user, :collaborator, :observer.
#
# Normalizations:
# - email_address: Strips and downcases the email address before saving.
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy



  has_many :campaigns

  has_many :templates

  has_one :credit_account
  has_many :transactions

  has_many :support_requests


  # belongs_to :role, optional: true
  belongs_to :plan, optional: true

  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  enum :role, [
    :admin,
    :campaign_manager,
    :designer,
    :analyst,
    :user,
    :collaborator,
    :observer,
    :usuario_prepago,
    :colaborador_prepago,
    :observador_prepago
  ], default: :user


  def can?(action)
    Permissions.allowed?(role, action)
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
