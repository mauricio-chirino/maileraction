class Template < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true
  has_many :template_blocks, dependent: :destroy

  validates :name, :html_content, :category, :theme, presence: true

  scope :by_category, ->(cat) { where(category: cat) }
  scope :by_theme,    ->(theme) { where(theme: theme) }
end
