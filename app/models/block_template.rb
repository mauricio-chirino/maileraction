class BlockTemplate < ApplicationRecord
  belongs_to :user, optional: true, primary_key: "uuid", foreign_key: "user_id"
  has_many :email_blocks, dependent: :nullify, primary_key: "uuid", foreign_key: "block_template_id"

  validates :name, presence: true
  validates :html_content, presence: true

  # Puedes agregar scopes para buscar por categoría o visibilidad
  scope :publics, -> { where(public: true) }
end
