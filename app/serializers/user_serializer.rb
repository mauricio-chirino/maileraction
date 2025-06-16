class UserSerializer < ActiveModel::Serializer
  attributes :id, :uuid, :email_address, :role, :plan_id, :plan_uuid, :plan_name

  def plan_name
    object.plan&.name
  end
end
