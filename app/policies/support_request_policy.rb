# SupportRequestPolicy is a policy class that defines authorization rules for creating support requests.
# It inherits from ApplicationPolicy.
#
# Methods:
# - create?: Checks if the user is present to allow the creation of a support request.
#
# Example usage:
#   policy = SupportRequestPolicy.new(user, support_request)
#   policy.create? # => true if user is present, false otherwise
class SupportRequestPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
