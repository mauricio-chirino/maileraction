class UserSerializer < ActiveModel::Serializer
  attributes :id, :email_address, :role, :plan_id, :plan_name

  def plan_name
    object.plan&.name
  end
end
