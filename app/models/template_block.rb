class TemplateBlock < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :template, foreign_key: "template_uuid", primary_key: "uuid"

  validates :block_type, :html_content, presence: true
end
