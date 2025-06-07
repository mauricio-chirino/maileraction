class Template < ApplicationRecord
  belongs_to :user

  has_many :template_blocks, dependent: :destroy

  validates :name, :html_content, presence: true
end
