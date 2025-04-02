# app/policies/public_email_record_policy.rb
class PublicEmailRecordPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user_has_access?
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    user_has_access?
  end

  def show?
    user_has_access?
  end

  def search?
    user_has_access?
  end

  private

  def user_has_access?
    user.admin? ||
      user.campaign_manager? ||
      user.analyst? ||
      user.user? ||
      user.collaborator? ||
      user.usuario_prepago? ||
      user.colaborador_prepago?
  end
end
