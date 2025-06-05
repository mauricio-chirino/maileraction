module Api
  module V1
    class CreditAccountsController < ApplicationController
      # before_action :authenticate_user!
      # before_action :authenticate_jwt_user!

      # GET /api/v1/credit_account
      def show
        credit_account = current_user.credit_account
        authorize credit_account || CreditAccount

        render json: credit_account, serializer: CreditAccountSerializer, include: [ "plan", "transactions" ]
      end



      # POST /api/v1/credit_accounts/consume_campaign
      def consume_campaign
        credit_account = current_user.credit_account
        authorize credit_account || CreditAccount

        if params[:campaign_id].blank?
          render json: { error: "Se requiere campaign_id." }, status: :bad_request and return
        end

        campaign = Campaign.find_by(id: params[:campaign_id])
        unless campaign
          render json: { error: "Campaña no encontrada." }, status: :not_found and return
        end

        email_count = params[:emails_sent].to_i
        if email_count <= 0
          render json: { error: "Cantidad de correos inválida." }, status: :unprocessable_entity and return
        end

        if credit_account.nil? || credit_account.available_credit < email_count
          render json: { error: "Créditos insuficientes." }, status: :unprocessable_entity and return
        end

        transaction = nil

        # Transacción atómica
        ActiveRecord::Base.transaction do
          credit_account.decrement!(:available_credit, email_count)

          transaction = Transaction.create!(
            user: current_user,
            credit_account: credit_account,
            amount: email_count,
            status: "consumed",
            payment_method: "campaign",
            campaign_id: campaign.id
          )
        end

        render json: {
          credit_account: CreditAccountSerializer.new(credit_account),
          transaction: TransactionSerializer.new(transaction)
        }
      end







      # POST /api/v1/credit_accounts/assign_initial
      def assign_initial
        authorize CreditAccount, :assign_initial?

        user = User.find_by(id: params[:user_id])
        return render json: { error: "Usuario no encontrado." }, status: :not_found if user.nil?

        credit_account = user.credit_account || user.build_credit_account

        if credit_account.persisted?
          render json: { error: "El usuario ya tiene créditos asignados." }, status: :unprocessable_entity # Si ya existe, respondemos con error 422 (Unprocessable Entity), porque no se puede asignar dos veces.
          return
        end

        credit_account.available_credit = 30
        credit_account.save!

        Transaction.create!(
          user: user,
          credit_account: credit_account,
          amount: 30,
          status: "assigned",
          payment_method: "initial"
        )

        render json: credit_account, serializer: CreditAccountSerializer, status: :created
      end



      # POST /api/v1/credit_accounts/consume
      def consume
        credit_account = current_user.credit_account
        authorize credit_account, :consume?

        amount = params[:amount].to_i

        if credit_account.nil?
          render json: { error: "No tienes cuenta de crédito asociada." }, status: :not_found
          return
        end

        if amount <= 0
          render json: { error: "El monto debe ser mayor a cero." }, status: :unprocessable_entity
          return
        end

        if credit_account.available_credit < amount
          render json: { error: "Créditos insuficientes." }, status: :forbidden
          return
        end

        credit_account.available_credit -= amount
        credit_account.save!

        transaction = Transaction.create!(
          user: current_user,
          credit_account: credit_account,
          amount: amount,
          status: "consumed",
          payment_method: "credits"
        )

        render json: {
          remaining_credits: credit_account.available_credit,
          transaction: transaction
        }, serializer: CreditConsumeResponseSerializer, status: :ok
      end
    end
  end
end
