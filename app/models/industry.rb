class Industry < ApplicationRecord
  has_many :email_records
  has_many :campaigns

  validates :name, presence: true, uniqueness: true
end
