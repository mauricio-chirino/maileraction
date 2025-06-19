class Current < ActiveSupport::CurrentAttributes
self.primary_key = "uuid"
  attribute :session
  delegate :user, to: :session, allow_nil: true
end
