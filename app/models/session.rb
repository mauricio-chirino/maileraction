class Session < ApplicationRecord
  self.primary_key = "uuid"

  # Solo si ya migraste a user_uuid:
  belongs_to :user, primary_key: "uuid", foreign_key: "user_uuid"

  before_validation :generate_session_token, on: :create

  validates :session_token, presence: true, uniqueness: true

  private

  def generate_session_token
    self.session_token ||= SecureRandom.hex(32)
  end
end
