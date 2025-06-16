module Api
  module V1
    class CreditAccountsController < ApplicationController
      # before_action :authenticate_user!
      # before_action :authenticate_jwt_user!

      # GET /api/v1/credit_account
      def show
        credit_account = CreditAccount.find_by(user_uuid: current_user.uuid)
        authorize credit_account || CreditAccount

        render json: credit_account, serializer: CreditAccountSerializer, include: [ "plan", "transactions" ]
      end

      # POST /api/v1/credit_accounts/consume_campaign
      def consume_campaign
        credit_account = CreditAccount.find_by(user_uuid: current_user.uuid)
        authorize credit_account || CreditAccount

        if params[:campaign_uuid].blank?
          render json: { error: "Se requiere campaign_uuid." }, status: :bad_request and return
        end

        campaign = Campaign.find_by(uuid: params[:campaign_uuid])
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
            user_uuid: current_user.uuid,
            credit_account_uuid: credit_account.uuid,
            amount: email_count,
            status: "consumed",
            payment_method: "campaign",
            campaign_uuid: campaign.uuid
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

        user = User.find_by(uuid: params[:user_uuid])
        return render json: { error: "Usuario no encontrado." }, status: :not_found if user.nil?

        credit_account = CreditAccount.find_by(user_uuid: user.uuid) || user.build_credit_account

        if credit_account.persisted?
          render json: { error: "El usuario ya tiene créditos asignados." }, status: :unprocessable_entity
          return
        end

        credit_account.available_credit = 30
        credit_account.save!

        Transaction.create!(
          user_uuid: user.uuid,
          credit_account_uuid: credit_account.uuid,
          amount: 30,
          status: "assigned",
          payment_method: "initial"
        )

        render json: credit_account, serializer: CreditAccountSerializer, status: :created
      end

      # POST /api/v1/credit_accounts/consume
      def consume
        credit_account = CreditAccount.find_by(user_uuid: current_user.uuid)
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
          user_uuid: current_user.uuid,
          credit_account_uuid: credit_account.uuid,
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
