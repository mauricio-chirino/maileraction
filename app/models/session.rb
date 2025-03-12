class Session < ApplicationRecord
  belongs_to :user

  before_validation :generate_session_token, on: :create

  validates :session_token, presence: true, uniqueness: true

  private

  def generate_session_token
    self.session_token ||= SecureRandom.hex(32)
  end
end
