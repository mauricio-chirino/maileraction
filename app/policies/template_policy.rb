
# Policy class for Template model to handle authorization.
# Esta clase define los permisos para acceder a las plantillas de usuario.
#
# - index?: permite a cualquier usuario autenticado ver las plantillas disponibles (públicas o propias).
# - show?: permite ver una plantilla si es del usuario o si está marcada como pública.
# - create?: permite crear plantillas a cualquier usuario autenticado.
# - update?: permite actualizar solo las plantillas propias.
# - destroy?: permite eliminar solo las plantillas propias.
#
class TemplatePolicy < ApplicationPolicy
  def index?
    user.present? # cualquier usuario autenticado puede ver la lista
  end

  def show?
    user.present? && (record.user_id == user.id || record.shared?)
  end

  def create?
    user.present?
  end

  def update?
    user.present? && record.user_id == user.id
  end

  def destroy?
    user.present? && record.user_id == user.id
  end

  def preview?
    show?
  end
end
