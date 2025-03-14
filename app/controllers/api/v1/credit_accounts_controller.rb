module Api
  module V1
    class CreditAccountsController < ApplicationController
      before_action :authenticate_user!

      # GET /api/v1/credit_account
      def show
        credit_account = current_user.credit_account
        authorize credit_account || CreditAccount

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

      # POST /api/v1/credit_accounts/assign_initial
      def assign_initial
        user = User.find(params[:user_id])
        authorize CreditAccount, :assign_initial?

        credit_account = user.credit_account || user.build_credit_account

        if user.credit_account.present?
          render json: { message: "El usuario ya tiene créditos asignados." }, status: :ok
        else
          credit_account.available_credit = 30
          credit_account.save!

          Transaction.create!(
            user: user,
            credit_account: credit_account,
            amount: 30,
            status: "assigned",
            payment_method: "initial"
          )

          render json: { message: "Créditos iniciales asignados.", id: credit_account.id }, status: :created
        end
      end


      # POST /api/v1/credit_accounts/consume
      def consume
        credit_account = current_user.credit_account
        authorize credit_account || CreditAccount

        amount = params[:amount].to_i

        if amount <= 0
          render json: { error: "Monto inválido." }, status: :unprocessable_entity
          return
        end

        if credit_account.nil? || credit_account.available_credit < amount
          render json: { error: "Créditos insuficientes." }, status: :unprocessable_entity
          return
        end

        credit_account.available_credit -= amount
        credit_account.save!

        Transaction.create!(
          user: current_user,
          credit_account: credit_account,
          amount: amount,
          status: "consumed",
          payment_method: "credits"
        )

        render json: { message: "Créditos consumidos." }, status: :ok
      end
    end
  end
end
