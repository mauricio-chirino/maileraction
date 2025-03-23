puts "⏳ Asociando campaign_id en rebotes antiguos..."

Bounce.where(campaign_id: nil).find_each do |bounce|
  log = EmailLog.find_by(email_record_id: bounce.email_record_id)
  if log&.campaign_id
    bounce.update!(campaign_id: log.campaign_id)
    puts "✔️ Bounce ##{bounce.id} asociado a Campaign ##{log.campaign_id}"
  else
    puts "⚠️ Bounce ##{bounce.id} no pudo asociarse a ningún Campaign"
  end
end

puts "✅ Proceso completado."
