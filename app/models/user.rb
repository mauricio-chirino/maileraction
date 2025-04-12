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




  # Método público solo para el controlador de registro
  def generate_remember_token_value
    self.remember_token = User.generate_remember_token
  end





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


  validates :name, presence: true
  validates :company, presence: true


  def can?(action)
    Permissions.allowed?(role, action)
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }


  # Método para generar el remember_token
  def self.generate_remember_token
    SecureRandom.urlsafe_base64(16)
  end



  # Método para enviar un correo con el enlace de restablecimiento de contraseña
  def send_password_reset_email
    self.password_reset_token = generate_password_reset_token
    self.password_reset_sent_at = Time.now
    save!
    UserMailer.password_reset(self).deliver_now
  end



  private

    # Genera un token de restablecimiento de contraseña
    def generate_password_reset_token
      SecureRandom.urlsafe_base64
    end
end
