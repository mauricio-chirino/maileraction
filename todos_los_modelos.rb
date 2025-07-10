class ApplicationRecord < ActiveRecord::Base
self.primary_key = "uuid"
  primary_abstract_class
end
class BlockTemplate < ApplicationRecord
  belongs_to :user, optional: true, primary_key: "uuid", foreign_key: "user_id"
  has_many :email_blocks, dependent: :nullify, primary_key: "uuid", foreign_key: "block_template_id"

  validates :name, presence: true
  validates :html_content, presence: true

  # Puedes agregar scopes para buscar por categoría o visibilidad
  scope :publics, -> { where(public: true) }
end
# app/models/bounce.rb

class Bounce < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  after_create :refund_credit_if_prepago

  private

  def refund_credit_if_prepago
    return unless campaign&.usuario_prepago? # Agregado & por si campaign es nil

    account = campaign.user.credit_account
    account.increment!(:credits, 1)

    Rails.logger.info("💸 Crédito devuelto a #{campaign.user.email_address} por rebote de #{email}")
  end
end
# app/models/campaign_email.rb
class CampaignEmail < ApplicationRecord
  self.primary_key = "uuid"

  # Relaciona por UUID si la tabla ya tiene campaign_uuid y email_record_uuid:
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true

  # Si tu tabla solo tiene los campos viejos (campaign_id, email_record_id), deja así:
  # belongs_to :campaign
  # belongs_to :email_record
end
# La clase Campaign representa una campaña de correo electrónico en la aplicación.

#
# Relaciones:
# - Pertenece a un usuario (user).
# - Pertenece a una industria (industry).
# - Tiene muchos correos de campaña (campaign_emails).
# - Tiene muchos registros de correo electrónico (email_records) a través de campaign_emails.
# - Tiene muchos registros de logs de correo electrónico (email_logs).
# - Tiene muchos rebotes (bounces).
# - Pertenece a una plantilla (template) opcional.
#
# Delegaciones:
# - Delegar el método `content` a la plantilla (template), permitiendo nil.
#
# Validaciones:
# - `email_limit` debe ser un número mayor que 0.
# - `status` debe estar incluido en los valores: 'pending', 'sending', 'completed', 'failed'.
# - `subject` debe estar presente.
# - `body` debe estar presente.
#
# Validaciones personalizadas:
# - `must_have_recipients`: La campaña debe tener destinatarios. Si la industria o el límite de correos electrónicos es nil, se omite la validación. Si no hay destinatarios, se agrega un error a la base.

class Campaign < ApplicationRecord
  self.primary_key = "uuid"

  # Callbacks y valores por defecto
  after_initialize do
    self.status ||= "pending"
    set_default_canvas_cleared
  end

  # RELACIONES SOLO CON UUIDs
  belongs_to :user,     foreign_key: "user_uuid",     primary_key: "uuid"
  belongs_to :industry, foreign_key: "industry_uuid", primary_key: "uuid"
  belongs_to :template, foreign_key: "template_uuid", primary_key: "uuid", optional: true

  has_many :campaign_emails, foreign_key: "campaign_uuid", primary_key: "uuid"
  has_many :email_records, through: :campaign_emails, source: :email_record

  has_many :email_logs,   foreign_key: "campaign_uuid", primary_key: "uuid"
  has_many :bounces,      foreign_key: "campaign_uuid", primary_key: "uuid"
  has_many :email_blocks, foreign_key: "campaign_uuid", primary_key: "uuid", dependent: :destroy

  # Validaciones
  validates :email_limit, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[pending sending completed failed cancelled] }
  validates :subject, presence: true
  validate  :must_have_recipients
  validate  :body_or_template_present

  # Delegaciones (ajusta según tu template)
  delegate :content, to: :template, allow_nil: true

  # save tyoe template or visual botton
  enum initial_creation_method: { template: 0, visual: 1 }

  # Métodos de validación
  def body_or_template_present
    if body.blank? && template&.content.blank?
      errors.add(:body, "no puede estar vacío si no se selecciona una plantilla con contenido.")
    end
  end

  private

  def must_have_recipients
    return if industry.nil? || email_limit.nil?
    recipients_count = EmailRecord.where(industry_uuid: industry.uuid).limit(email_limit).count
    if recipients_count.zero?
      errors.add(:base, "La campaña no tiene destinatarios.")
    end
  end

  def set_default_canvas_cleared
    self.canvas_cleared = false if self.canvas_cleared.nil?
  end
end
class CreditAccount < ApplicationRecord
  self.primary_key = "uuid"

  # Relación a usuario por UUID (mejor práctica)
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  # Relación a plan vía usuario
  has_one :plan, through: :user

  # Relación a transacciones por UUID
  has_many :transactions, primary_key: "uuid", foreign_key: "credit_account_uuid"

  validates :available_credit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
class Current < ActiveSupport::CurrentAttributes
self.primary_key = "uuid"
  attribute :session
  delegate :user, to: :session, allow_nil: true
end
class EmailBlock < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true
  belongs_to :block_template, primary_key: "uuid", foreign_key: "block_template_uuid", optional: true

  validates :block_type, presence: true
  validates :html_content, presence: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  default_scope { order(:position) }

  after_update_commit do
    broadcast_replace_later_to "campaign_#{campaign_uuid}",
      partial: "web/dashboard/campaigns/shared/email_block",
      locals: { email_block: self },
      target: "block_#{uuid}"
  end

  def category
    block_type.split("-").first
  end
end
# app/models/email_error_log.rb
class EmailErrorLog < ApplicationRecord
  self.primary_key = "uuid"

  # Asociaciones, si las tienes
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  # belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true # Solo si la agregas en migración

  # Validaciones (ajusta según tus necesidades)
  # validates :error, presence: true
end
class EmailEventLog < ApplicationRecord
  self.primary_key = "uuid"
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  validates :email, presence: true
  validates :event_type, presence: true
end
# app/models/email_log.rb
class EmailLog < ApplicationRecord
  self.primary_key = "uuid"

  def self.statuses
    %w[success error delivered]
  end

  # Asociaciones usando los nuevos UUIDs
  belongs_to :campaign,   primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  belongs_to :email_record, primary_key: "uuid", foreign_key: "email_record_uuid", optional: true

  # Scopes para trazabilidad de reembolsos
  scope :refunded,     -> { where(credit_refunded: true) }
  scope :not_refunded, -> { where(credit_refunded: [ false, nil ]) }

  validates :status, inclusion: { in: statuses }

  # Métodos de conveniencia para manejar estados
  def success?
    status == "success"
  end

  def error?
    status == "error"
  end

  def delivered?
    status == "delivered"
  end

  def refunded?
    credit_refunded
  end
end
class EmailRecord < ApplicationRecord
  self.primary_key = "uuid"
  belongs_to :industry
  has_many :email_logs
  has_many :bounces
  has_many :campaign_emails
  has_many :campaigns, through: :campaign_emails

  validates :email, presence: true, uniqueness: true


  def increment_bounce!
    increment!(:bounces_count)
    update!(active: false) if bounces_count >= 3
  end
end
class Industry < ApplicationRecord
  self.primary_key = "uuid"
  has_many :email_records
  has_many :campaigns
  has_many :public_email_records, dependent: :nullify



  validates :name, :name_en, presence: true
  validates :name, uniqueness: true
  validates :name_en, uniqueness: true

  scope :by_name, ->(name) { where(name: name) }

  def display(locale = :es)
    locale.to_s == "en" ? name_en : name
  end
end


# The Notification model represents a notification that belongs to a user.
# It includes validations for the presence of title and body, and provides
# a scope to retrieve unread notifications. Additionally, it has an instance
# method to mark a notification as read.
#
# Associations:
# - belongs_to :user
#
# Validations:
# - title: must be present
# - body: must be present
#
# Scopes:
# - unread: retrieves notifications that have not been read (read_at is nil)
#
# Instance Methods:
# - mark_as_read!: sets the read_at attribute to the current time
class Notification < ApplicationRecord
  self.primary_key = "uuid"
   belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  validates :title, :body, presence: true

  scope :unread, -> { where(read_at: nil) }

  def mark_as_read!
    update(read_at: Time.current)
  end
end
# app/models/permissions.rb

class Permissions
  self.primary_key = "uuid"
  ROLE_PERMISSIONS = {
    admin: %i[
      manage_users manage_campaigns manage_templates manage_credits
      view_reports access_support
    ],
    campaign_manager: %i[
      manage_campaigns view_reports access_support
    ],
    designer: %i[
      manage_templates
    ],
    analyst: %i[
      view_reports
    ],
    user: %i[
      create_campaigns view_own_reports access_support
    ],
    collaborator: %i[
      view_campaigns
    ],
    observer: %i[
      view_campaigns
    ],
    usuario_prepago: %i[
      create_campaigns view_own_reports
    ],
    colaborador_prepago: %i[
      view_campaigns
    ],
    observador_prepago: %i[
      view_campaigns
    ]
  }.freeze

  def self.allowed_actions_for(role)
    ROLE_PERMISSIONS[role.to_sym] || []
  end

  def self.allowed?(role, action)
    allowed_actions_for(role).include?(action)
  end
end
class Plan < ApplicationRecord
self.primary_key = "uuid"
  has_many :users

  validates :name, presence: true
end
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
class Role < ApplicationRecord
  self.primary_key = "uuid"
  has_many :users # solo si luego users tendrá role_uuid
  validates :name, presence: true, uniqueness: true
end
class ScrapeTarget < ApplicationRecord
  self.primary_key = "uuid"
  enum :status, { pending: 0, done: 1, failed: 2 }, prefix: true
  validates :url, presence: true, uniqueness: true
end
class ScrapingSource < ApplicationRecord
self.primary_key = "uuid"
  validates :url, presence: true, uniqueness: true
end
class Session < ApplicationRecord
  self.primary_key = "uuid"

  # Solo si ya migraste a user_uuid:
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  before_validation :generate_session_token, on: :create

  validates :session_token, presence: true, uniqueness: true

  private

  def generate_session_token
    self.session_token ||= SecureRandom.hex(32)
  end
end
# app/models/support_request.rb
class SupportRequest < ApplicationRecord
  self.primary_key = "uuid"
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  validates :message, presence: true

  # Mejorando la definición de `enum`
  enum :category, { bug: 0, idea: 1, question: 2 }
  enum :status, { open: 0, in_progress: 1, resolved: 2 }
  enum :priority, { low: 0, medium: 1, high: 2 }
  enum :source, { web: 0, mobile: 1, internal: 2 }

  # Scopes útiles para consultas frecuentes
  scope :open, -> { where(status: :open) }
  scope :by_priority, ->(level) { where(priority: level) }
end
class TemplateBlock < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :template, foreign_key: "template_uuid", primary_key: "uuid"

  validates :block_type, :html_content, presence: true
end
class Template < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true
  has_many :template_blocks, dependent: :destroy

  validates :name, :html_content, :category, :theme, presence: true

  scope :by_category, ->(cat) { where(category: cat) }
  scope :by_theme,    ->(theme) { where(theme: theme) }
end
class Transaction < ApplicationRecord
  self.primary_key = "uuid"

  # Relación con usuario usando uuid
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true

  # Relación con cuenta de créditos usando uuid
  belongs_to :credit_account, primary_key: "uuid", foreign_key: "credit_account_uuid", optional: true

  # Relación con campaña usando uuid
  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true

  validates :amount, numericality: { greater_than: 0 }
end
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
  self.primary_key = "uuid"

  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :campaigns, foreign_key: "user_uuid"
  has_many :templates, foreign_key: "user_uuid"
  has_one :credit_account, foreign_key: "user_uuid"
  has_many :transactions, foreign_key: "user_uuid"
  has_many :support_requests, foreign_key: "user_uuid"
  has_many :block_templates, foreign_key: "user_uuid"
  has_many :email_blocks, foreign_key: "user_uuid"

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

  validates :name, presence: true, unless: -> { password_reset_token.present? }
  validates :company, presence: true, unless: -> { password_reset_token.present? }

  def can?(action)
    Permissions.allowed?(role, action)
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def generate_remember_token_value
    self.remember_token = User.generate_remember_token
  end

  def self.generate_remember_token
    SecureRandom.urlsafe_base64(16)
  end

  def send_password_reset_email
    self.password_reset_token = generate_password_reset_token
    self.password_reset_sent_at = Time.now
    save!
    UserMailer.password_reset(self).deliver_now
  end

  private

  def generate_password_reset_token
    SecureRandom.urlsafe_base64
  end
end
