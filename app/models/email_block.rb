class EmailBlock < ApplicationRecord
  self.primary_key = "uuid"

  belongs_to :campaign, primary_key: "uuid", foreign_key: "campaign_uuid", optional: true
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid", optional: true
  belongs_to :block_template, primary_key: "uuid", foreign_key: "block_template_uuid", optional: true

  validates :block_type, presence: true
  validates :html_content, presence: true
  validates :position, numericality: { only_integer: true }, allow_nil: true

  default_scope { order(:position) }

  after_update_commit do
    broadcast_replace_later_to "campaign_#{campaign_uuid}",
      partial: "web/dashboard/campaigns/shared/email_block",
      locals: { email_block: self },
      target: "block_#{uuid}"
  end

  def category
    block_type.split("-").first
  end
end
