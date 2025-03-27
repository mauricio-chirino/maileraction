class EmailEventLog < ApplicationRecord
  belongs_to :campaign, optional: true

  validates :email, presence: true
  validates :event_type, presence: true
end
