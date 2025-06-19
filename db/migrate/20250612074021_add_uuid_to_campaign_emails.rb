class AddUuidToCampaignEmails < ActiveRecord::Migration[8.0]
  def up
    add_column :campaign_emails, :uuid, :uuid, default: "gen_random_uuid()", null: false unless column_exists?(:campaign_emails, :uuid)
    add_index :campaign_emails, :uuid, unique: true unless index_exists?(:campaign_emails, :uuid)
    # CampaignEmail.reset_column_information
    # CampaignEmail.where(uuid: nil).find_each { |ce| ce.update_column(:uuid, SecureRandom.uuid) }
  end
  def down
    remove_index :campaign_emails, :uuid if index_exists?(:campaign_emails, :uuid)
    remove_column :campaign_emails, :uuid if column_exists?(:campaign_emails, :uuid)
  end
end
