# frozen_string_literal: true

# Todos los métodos por defecto devuelven false, es decir
# Nadie tiene permiso para hacer nada, a menos que sobreescribas los métodos en una policy hija.

class ApplicationPolicy
  attr_reader :user, :record

  # Este initialize es llamado automáticamente por Pundit cuando haces authorize @objeto.
  def initialize(user, record)
    @user = user        # el usuario autenticado (current_user)
    @record = record    # el modelo o recurso que estamos autorizando (ej: Campaign, User, etc)
  end

  def index?; false; end
  def show?; false; end
  def create?; false; end
  def new?; create?; end
  def update?; false; end
  def edit?; update?; end
  def destroy?; false; end



  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
