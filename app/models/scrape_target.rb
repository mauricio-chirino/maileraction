class ScrapeTarget < ApplicationRecord
  enum :status, { pending: 0, done: 1, failed: 2 }, prefix: true

  validates :url, presence: true, uniqueness: true
end
