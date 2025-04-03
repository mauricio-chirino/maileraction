class ScrapeTarget < ApplicationRecord
  enum status: [ :pending, :done, :failed ], prefix: true

  validates :url, presence: true, uniqueness: true
end
