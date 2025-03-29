class CampaignPolicy < ApplicationPolicy
  def allowed_roles_for_creation?
    %w[admin campaign_manager user usuario_prepago].include?(user.role)
  end



  # Permite crear campañas si el usuario es:
  # Administrador Gestor de campañas Usuario normal Usuario prepago
  def create?
    allowed_roles_for_creation?
  end



  def index?
    user.admin? || user.campaign_manager? || user.user? || user.usuario_prepago?
  end

  # Permite ver una campaña si:
  # El usuario es admin, o
  # Es el dueño de la campaña

  def show?
    user.admin? || record.user_id == user.id
  end



  # Permite editar una campaña si:
  # El usuario es admin, o
  # Es el dueño de la campaña
  # El usuario es gestor de campañas
  # El usuario es colaborador prepago
  # El usuario es observador prepago
  # El usuario es analista
  def update?
    can_manage_campaigns? || owns_campaign?
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  # Permite ver las estadísticas si:
  # El usuario es analista, o
  # Es el creador de la campaña
  def stats?
    user.admin? || user.analyst? || user.observer? || record.user_id == user.id
  end

  # Autoriza el envío de la campaña si el usuario tiene un rol que puede enviar:
  # Admin
  # Gestor de campañas
  # Usuario prepago
  def send?
    user.admin? || user.campaign_manager? || user.usuario_prepago?
  end


  def cancel?
    user.admin? || record.user_id == user.id
  end

  # Permite ver la lista de campañas si el usuario es admin o el creador de la campaña.
  def owns_campaign?
    record.user_id == user.id
  end


  # Permite ver las estadísticas de la campaña si el usuario es analista o el creador de la campaña.
  def can_manage_campaigns?
    user.admin? || user.campaign_manager?
  end






  # Permite ver las estadísticas de la campaña si el usuario es analista o el creador de la campaña.
  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(user_id: user.id)
    end
  end
end
