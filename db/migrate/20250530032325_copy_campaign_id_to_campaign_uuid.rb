class CopyCampaignIdToCampaignUuid < ActiveRecord::Migration[8.0]
  def up
    # campaign_emails
    execute <<-SQL
      UPDATE campaign_emails ce
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE ce.campaign_id = c.id;
    SQL

    # bounces
    execute <<-SQL
      UPDATE bounces b
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE b.campaign_id = c.id;
    SQL

    # email_blocks
    execute <<-SQL
      UPDATE email_blocks eb
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE eb.campaign_id = c.id;
    SQL

    # email_error_logs
    execute <<-SQL
      UPDATE email_error_logs eel
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE eel.campaign_id = c.id;
    SQL

    # email_event_logs
    execute <<-SQL
      UPDATE email_event_logs eel
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE eel.campaign_id = c.id;
    SQL

    # email_logs
    execute <<-SQL
      UPDATE email_logs el
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE el.campaign_id = c.id;
    SQL

    # transactions
    execute <<-SQL
      UPDATE transactions t
      SET campaign_uuid = c.uuid
      FROM campaigns c
      WHERE t.campaign_id = c.id;
    SQL
  end
end
