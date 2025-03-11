class CampaignPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.admin? || record.user_id == user.id
  end

  def create?
    user.campaign_manager? || user.admin? || user.user? || user.usuario_prepago?
  end

  def update?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  def stats?
    user.analyst? || record.user_id == user.id
  end

  def send?
    user.campaign_manager? || user.admin? || user.usuario_prepago?
  end





  #   def index?
  #     user.admin? || user.campaign_manager? || user.user?
  #   end

  #   def create?
  #     user.admin? || user.campaign_manager?
  #   end

  #   def update?
  #     user.admin? || (user.campaign_manager? && record.user_id == user.id)
  #   end

  #   def destroy?
  #     user.admin?
  #   end

  #   class Scope < Scope
  #     def resolve
  #       if user.admin?
  #         scope.all
  #       else
  #         scope.where(user: user)
  #       end
  #     end
  #   end
  #
end
