class BouncePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class BouncePolicy < ApplicationPolicy
    def index?
      user.present?
    end

    def show?
      record.email_record.campaign.user_id == user.id
    end

    class Scope < Scope
      def resolve
        scope.joins(email_record: :campaign).where(campaigns: { user_id: user.id })
      end
    end
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
