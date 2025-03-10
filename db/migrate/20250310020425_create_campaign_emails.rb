class CreateCampaignEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_emails do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :email_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
