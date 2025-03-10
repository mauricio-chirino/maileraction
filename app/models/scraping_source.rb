class ScrapingSource < ApplicationRecord
  validates :url, presence: true, uniqueness: true
end
