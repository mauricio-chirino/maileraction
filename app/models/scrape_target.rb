class ScrapeTarget < ApplicationRecord
  enum status: { pending: "pending", done: "done", failed: "failed" }, _prefix: true

  validates :url, presence: true, uniqueness: true
end
