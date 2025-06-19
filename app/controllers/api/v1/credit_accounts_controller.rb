module Api
  module V1
    class CreditAccountsController < ApplicationController
      def show
        credit_account = CreditAccount.find_by(user_uuid: current_user.uuid)
        authorize credit_account || CreditAccount
        render json: credit_account, serializer: CreditAccountSerializer, include: [ "plan", "transactions" ]
      end

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

      # Los otros métodos (assign_initial, consume, etc.) ya los tienes migrados correctamente.
    end
  end
end
