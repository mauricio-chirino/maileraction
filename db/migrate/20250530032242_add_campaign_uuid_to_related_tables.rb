class AddCampaignUuidToRelatedTables < ActiveRecord::Migration[8.0]
  def change
    add_column :campaign_emails, :campaign_uuid, :uuid
    add_column :bounces, :campaign_uuid, :uuid
    add_column :email_blocks, :campaign_uuid, :uuid
    add_column :email_error_logs, :campaign_uuid, :uuid
    add_column :email_event_logs, :campaign_uuid, :uuid
    add_column :email_logs, :campaign_uuid, :uuid
    add_column :transactions, :campaign_uuid, :uuid

    add_index :campaign_emails, :campaign_uuid
    add_index :bounces, :campaign_uuid
    add_index :email_blocks, :campaign_uuid
    add_index :email_error_logs, :campaign_uuid
    add_index :email_event_logs, :campaign_uuid
    add_index :email_logs, :campaign_uuid
    add_index :transactions, :campaign_uuid
  end
end
