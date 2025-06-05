# Métricas incluidas en el JSON:
# Campo	Descripción
# total_sent	Total de emails enviados en la campaña
# opens	Total de correos abiertos
# clicks	Total de clics registrados
# bounces	Total de correos rebotados
# open_rate	Porcentaje de apertura sobre el total enviado
# click_rate	Porcentaje de clics sobre el total enviado
# bounce_rate	Porcentaje de rebotes sobre el total enviado
# top_domains_bounced	Dominios que más generaron rebotes (ej: gmail.com, hotmail.com)


module Api
  module V1
    class StatsController < ApplicationController
      # before_action :authenticate_user!
      # before_action :authenticate_jwt_user!

      def show
        campaign = Campaign.find(params[:id])
        authorize campaign, :stats?

        total_sent = EmailLog.where(campaign_id: campaign.id).count
        opens = EmailLog.where(campaign_id: campaign.id).where.not(opened_at: nil).count
        clicks = EmailLog.where(campaign_id: campaign.id).where.not(clicked_at: nil).count
        bounces = Bounce.joins(:email_record).where(email_records: { campaign_id: campaign.id }).count

        stats = {
          total_sent: total_sent,
          opens: opens,
          clicks: clicks,
          bounces: bounces,
          open_rate: percentage(opens, total_sent),
          click_rate: percentage(clicks, total_sent),
          bounce_rate: percentage(bounces, total_sent),
          top_domains_bounced: top_bounced_domains(campaign)
        }

        render json: stats
      end

      private

      def percentage(value, total)
        return 0 if total == 0
        ((value.to_f / total) * 100).round(2)
      end

      def top_bounced_domains(campaign)
        Bounce.joins(:email_record)
              .where(email_records: { campaign_id: campaign.id })
              .group("SUBSTRING(email FROM POSITION('@' IN email) + 1)")
              .order("count_all DESC")
              .limit(5)
              .count
      end
    end
  end
end
