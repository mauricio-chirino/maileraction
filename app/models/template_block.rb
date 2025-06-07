class TemplateBlock < ApplicationRecord
  belongs_to :template

  validates :block_type, :html_content, presence: true
end
