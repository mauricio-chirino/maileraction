class BlockTemplate < ApplicationRecord
  belongs_to :user, optional: true
  has_many :email_blocks, dependent: :nullify

  validates :name, presence: true
  validates :html_content, presence: true

  # Puedes agregar scopes para buscar por categoría o visibilidad
  scope :publics, -> { where(public: true) }
end
