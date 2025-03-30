class SupportRequestSerializer < ActiveModel::Serializer
  attributes :id, :message, :category, :status, :priority, :source, :created_at, :updated_at
  belongs_to :user, serializer: UserSerializer

  def category
    object.category&.to_s
  end

  def status
    object.status&.to_s
  end

  def priority
    object.priority&.to_s
  end

  def source
    object.source&.to_s
  end
end
