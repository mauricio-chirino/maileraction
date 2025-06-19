class ScrapingSource < ApplicationRecord
self.primary_key = "uuid"
  validates :url, presence: true, uniqueness: true
end
