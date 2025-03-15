class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :amount, :status, :payment_method, :assigned_at

  def assigned_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")  # o el formato que quieras
  end
end
