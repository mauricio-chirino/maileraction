class TemplateBlock < ApplicationRecord
self.primary_key = "uuid"
  belongs_to :template

  validates :block_type, :html_content, presence: true
end
