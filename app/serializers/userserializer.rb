class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role_id, :plan_id
end
