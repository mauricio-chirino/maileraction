# Serializer for SupportRequest model.
# This serializer defines the attributes to be included in the JSON representation
# of a SupportRequest object.
#
# Attributes:
# - id: The unique identifier of the support request.
# - message: The message content of the support request.
# - category: The category of the support request.
# - status: The current status of the support request.
# - created_at: The timestamp when the support request was created.
class SupportRequestSerializer < ActiveModel::Serializer
  attributes :id, :message, :category, :status, :created_at, :updated_at
end
