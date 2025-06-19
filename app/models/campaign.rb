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
