class AddCampaignUuidToEmailBlocks < ActiveRecord::Migration[8.0]
  def up
    # Copiar datos existentes (campaign_id → campaign_uuid)
    execute <<-SQL
      UPDATE email_blocks SET campaign_uuid = campaigns.uuid FROM campaigns WHERE email_blocks.campaign_id = campaigns.id;
    SQL

    # Agregar índice si no existe ya (si existe, comenta o elimina esta línea)
    add_index :email_blocks, :campaign_uuid unless index_exists?(:email_blocks, :campaign_uuid)

    # Opcional: Eliminar columna antigua luego de verificar funcionalidad
    # remove_column :email_blocks, :campaign_id
  end

  def down
    # Opcional: Si eliminas columna antigua arriba, reagrégala acá para rollback
    # add_column :email_blocks, :campaign_id, :integer
  end
end
