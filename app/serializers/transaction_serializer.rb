class TransactionSerializer < ActiveModel::Serializer
attributes :id, :uuid, :user_id, :user_uuid, :credit_account_id, :credit_account_uuid, :campaign_id, :campaign_uuid, :amount, :status, :payment_method, :assigned_at


  def assigned_at
    object.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
end
