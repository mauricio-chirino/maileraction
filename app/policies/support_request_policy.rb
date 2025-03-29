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
  def index?
    user.admin? || user.support_team? || user == record.user
  end

  def show?
    user.admin? || user.support_team? || user == record.user
  end

  def create?
    user.present?
  end

  def update?
    user.admin? || user == record.user
  end

  def destroy?
    user.admin? || user == record.user
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(user_id: user.id)
    end
  end
end
