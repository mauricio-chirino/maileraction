class Role < ApplicationRecord
  self.primary_key = "uuid"
  has_many :users # solo si luego users tendrá role_uuid
  validates :name, presence: true, uniqueness: true
end
