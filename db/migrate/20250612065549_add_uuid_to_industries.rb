class AddUuidToIndustries < ActiveRecord::Migration[8.0]
  def up
    add_column :industries, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :industries, :uuid, unique: true
    # Copiar uuid a campaigns
    add_column :campaigns, :industry_uuid, :uuid
    execute "UPDATE campaigns SET industry_uuid = industries.uuid FROM industries WHERE campaigns.industry_id = industries.id;"
    add_index :campaigns, :industry_uuid
  end

  def down
    remove_column :campaigns, :industry_uuid
    remove_column :industries, :uuid
  end
end
