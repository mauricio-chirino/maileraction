class Template < ApplicationRecord
  belongs_to :user

  has_many :template_blocks, dependent: :destroy


  validates :name, :html_content, :category, :theme, presence: true
  # Para búsquedas y filtros rápidos:
  scope :by_category, ->(cat) { where(category: cat) }
  scope :by_theme,    ->(theme) { where(theme: theme) }
end
