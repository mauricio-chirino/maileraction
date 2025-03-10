class CampaignPolicy < ApplicationPolicy
  def index?
    user.admin? || user.campaign_manager? || user.user?
  end

  def create?
    user.admin? || user.campaign_manager?
  end

  def update?
    user.admin? || (user.campaign_manager? && record.user_id == user.id)
  end

  def destroy?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
