class EmailBlock < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  belongs_to :block_template, optional: true

  validates :block_type, presence: true
  validates :html_content, presence: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  # Puedes añadir lógica para ordenación
  default_scope { order(:position) }


  after_update_commit do
    broadcast_replace_later_to "campaign_#{campaign_id}",
      partial: "web/dashboard/campaigns/shared/email_block",
      locals: { email_block: self },
      target: "block_#{id}"
  end
end
