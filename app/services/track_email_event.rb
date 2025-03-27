class TrackEmailEvent
  def self.call(campaign_id:, email:, event_type:)
    campaign = Campaign.find_by(id: campaign_id)
    return unless campaign

    email_record = EmailRecord.find_by(email: email)
    return unless email_record

    email_log = EmailLog.find_by(campaign_id: campaign.id, email_record: email_record)
    return unless email_log

    timestamp = Time.current
    normalized_type = event_type.to_s.downcase

    case normalized_type
    when "open"
      email_log.update!(opened_at: timestamp)
    when "click"
      email_log.update!(clicked_at: timestamp)
    else
      Rails.logger.warn("Evento no reconocido: #{normalized_type}")
    end

    EmailEventLogger.call(
      email: email,
      campaign: campaign,
      event_type: normalized_type,
      metadata: {}
    )

    Rails.logger.info("Evento #{event_type} registrado para #{email}")
  end
end
