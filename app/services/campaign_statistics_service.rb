# app/services/campaign_statistics_service.rb
class CampaignStatisticsService
  def initialize(campaign)
    @campaign = campaign
  end

  def call
    logs = EmailLog.where(campaign_id: @campaign.id)
    bounces = Bounce.where(campaign_id: @campaign.id)

    total_sent = logs.count
    total_opens = logs.where.not(opened_at: nil).count
    total_clicks = logs.where.not(clicked_at: nil).count
    total_bounces = bounces.count

    open_rate = total_sent.positive? ? ((total_opens.to_f / total_sent) * 100).round(2) : 0
    click_rate = total_sent.positive? ? ((total_clicks.to_f / total_sent) * 100).round(2) : 0
    bounce_rate = total_sent.positive? ? ((total_bounces.to_f / total_sent) * 100).round(2) : 0

    {
      emails_sent: total_sent,
      emails_opened: total_opens,
      emails_clicked: total_clicks,
      emails_bounced: total_bounces,
      open_rate: "#{open_rate}%",
      click_rate: "#{click_rate}%",
      bounce_rate: "#{bounce_rate}%"
    }
  end
end
