

# The Notification model represents a notification that belongs to a user.
# It includes validations for the presence of title and body, and provides
# a scope to retrieve unread notifications. Additionally, it has an instance
# method to mark a notification as read.
#
# Associations:
# - belongs_to :user
#
# Validations:
# - title: must be present
# - body: must be present
#
# Scopes:
# - unread: retrieves notifications that have not been read (read_at is nil)
#
# Instance Methods:
# - mark_as_read!: sets the read_at attribute to the current time
class Notification < ApplicationRecord
  self.primary_key = "uuid"
   belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  validates :title, :body, presence: true

  scope :unread, -> { where(read_at: nil) }

  def mark_as_read!
    update(read_at: Time.current)
  end
end
