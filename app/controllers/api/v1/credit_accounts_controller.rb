module Api
  module V1
    class CreditAccountsController < ApplicationController
      before_action :authenticate_user!

      def show
        credit_account = current_user.credit_account
        authorize credit_account || CreditAccount  # En caso de nil, protege igual

        plan = current_user.plan
        transactions = current_user.transactions.order(created_at: :desc)

        render json: {
          credits: credit_account&.available_credit || 0,
          plan: {
            name: plan&.name,
            max_email: plan&.max_email,
            campaigna: plan&.campaigna
          },
          transactions: transactions.map do |t|
            {
              id: t.id,
              amount: t.amount,
              status: t.status,
              payment_method: t.payment_method,
              created_at: t.created_at
            }
          end
        }
      end
    end
  end
end
