class EmailBlock < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  belongs_to :block_template, optional: true

  validates :block_type, presence: true
  validates :html_content, presence: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  # Puedes añadir lógica para ordenación
  default_scope { order(:position) }
end
