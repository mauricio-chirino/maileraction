class User < ApplicationRecord
  has_secure_password # Habilita autenticación segura con bcrypt

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
end
