class CampaignPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  # Permite ver una campaña si:
  # El usuario es admin, o
  # Es el dueño de la campaña

  def show?
    user.admin? || record.user_id == user.id
  end

  # Permite crear campañas si el usuario es:
  # Administrador Gestor de campañas Usuario normal Usuario prepago
  def create?
    user.campaign_manager? || user.admin? || user.user? || user.usuario_prepago?
  end

  # Solo el administrador o el dueño de la campaña puede modificarla o eliminarla.
  def update?
    user.admin? || record.user_id == user.id
  end

  def destroy?
    user.admin? || record.user_id == user.id
  end

  # Permite ver las estadísticas si:
  # El usuario es analista, o
  # Es el creador de la campaña
  def stats?
    user.admin? || user.analyst? || record.user_id == user.id
  end

  # Autoriza el envío de la campaña si el usuario tiene un rol que puede enviar:
  # Admin
  # Gestor de campañas
  # Usuario prepago
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

    class Scope < Scope
      def resolve
        if user.admin?
         scope.all
        else
          scope.where(user_id: user.id)
        end
      end
    end
end
