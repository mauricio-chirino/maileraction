# db/scripts/simulate_campaign_stats.rb

campaign = Campaign.order("RANDOM()").first
puts "📣 Simulando para campaña ##{campaign.id} - #{campaign.subject}"

emails = EmailRecord.where(industry_id: campaign.industry_id).limit(campaign.email_limit)

emails.each_with_index do |email_record, index|
  # Alternar entre éxito y error para variar los datos
  status = index.even? ? "success" : "error"

  log = EmailLog.create!(
    campaign: campaign,
    email_record: email_record,
    status: status,
    opened_at: status == "success" ? Time.now - rand(1..60).minutes : nil,
    clicked_at: status == "success" && index % 3 == 0 ? Time.now - rand(1..60).minutes : nil
  )

  # Simular algunos rebotes solo para los fallidos
  if status == "error"
    Bounce.create!(
      email_record: email_record,
      campaign: campaign
    )
  end
end

puts "✅ Simulación completa. Consultá /api/v1/campaigns/#{campaign.id}/stats para ver los resultados."
