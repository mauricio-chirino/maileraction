
# Policy class for Template model to handle authorization.
# This class inherits from ApplicationPolicy and defines the following methods:
#
# index? - Allows any authenticated user to view the available templates.
# show? - Allows a user to view a template if they are the owner or if the template is public.
# create? - Allows any authenticated user to create a new template.
# update? - Allows a user to update a template if they are the owner.
# destroy? - Allows a user to delete a template if they are the owner.
#
class TemplatePolicy < ApplicationPolicy
  def index?
    true # cualquier usuario autenticado puede ver las plantillas disponibles
  end

  # Verifica si el usuario tiene permiso para ver el registro.
  #
  # @return [Boolean] true si el usuario está presente y es el propietario del registro o si el registro es público, de lo contrario false.
  def show?
    user.present? && (record.user_id == user.id || record.public?)
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
end
