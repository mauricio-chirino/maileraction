class CreditAccountPolicy < ApplicationPolicy
  def show?
    record.user_id == user.id || user.admin?
  end

  # 👇 Aquí agregamos la nueva política
  def consume_campaign?
    user.present?
  end


  def assign_initial?
    user.admin?
  end

  def consume?
    record.user_id == user.id || user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
