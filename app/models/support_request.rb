# SupportRequest model represents a request for support made by a user.
# It includes the following attributes:
# - user: references the user who made the support request.
# - message: the content of the support request, must be present.
# - category: the type of support request, must be one of 'bug', 'idea', or 'question'.
# - status: the current status of the support request, must be one of 'open', 'in_progress', or 'resolved'.
#
# Associations:
# - belongs_to :user
#
# Validations:
# - message: must be present.
# - category: must be one of 'bug', 'idea', or 'question'.
# - status: must be one of 'open', 'in_progress', or 'resolved'.
class SupportRequest < ApplicationRecord
  belongs_to :user


  validates :message, presence: true
  validates :category, inclusion: { in: %w[bug idea question] }
  validates :status, inclusion: { in: %w[open in_progress resolved] }
end
