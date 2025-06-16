class AddTemplateUuidToCampaigns < ActiveRecord::Migration[8.0]
  def up
    add_column :campaigns, :template_uuid, :uuid
    add_index  :campaigns, :template_uuid

    # Backfill si la columna existe en templates (esto pobla los valores para los registros existentes)
    execute <<-SQL
      UPDATE campaigns SET template_uuid = templates.uuid
      FROM templates
      WHERE campaigns.template_id = templates.id;
    SQL
  end

  def down
    remove_column :campaigns, :template_uuid
  end
end
