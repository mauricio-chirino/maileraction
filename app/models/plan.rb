class Plan < ApplicationRecord
self.primary_key = "uuid"
  has_many :users

  validates :name, presence: true
end
