class SupportRequest < ApplicationRecord
  belongs_to :user

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
