
class SupportRequest < ApplicationRecord
  belongs_to :user


  validates :message, presence: true
  # validates :category, inclusion: { in: %w[bug idea question] }

  # validates :status, inclusion: { in: %w[open in_progress resolved] }

  # validates :priority, inclusion: { in: %w[low medium high] }
  # validates :source, inclusion: { in: %w[web mobile internal] }
  #
  #


  enum :category, [ :bug, :idea, :question ]
  enum :status, [ :open, :in_progress, :resolved ]
  enum :priority, [ :low, :medium, :high ]
  enum :source, [ :web, :mobile, :internal ]

  # 🔍 Scopes útiles para consultas frecuentes
  scope :open, -> { where(status: :open) }
  scope :by_priority, ->(level) { where(priority: level) }
end
