class AddUuidsToEmailLogs < ActiveRecord::Migration[8.0]
  def up
    # 1. Agregar columnas UUID si no existen
    unless column_exists?(:email_logs, :campaign_uuid)
      add_column :email_logs, :campaign_uuid, :uuid
    end
    unless column_exists?(:email_logs, :email_record_uuid)
      add_column :email_logs, :email_record_uuid, :uuid
    end

    # 2. Copiar datos de las claves foráneas clásicas a los UUID
    execute <<-SQL
      UPDATE email_logs
      SET campaign_uuid = campaigns.uuid
      FROM campaigns
      WHERE email_logs.campaign_id = campaigns.id
        AND campaigns.uuid IS NOT NULL
        AND email_logs.campaign_id IS NOT NULL;
    SQL

    execute <<-SQL
      UPDATE email_logs
      SET email_record_uuid = email_records.uuid
      FROM email_records
      WHERE email_logs.email_record_id = email_records.id
        AND email_records.uuid IS NOT NULL
        AND email_logs.email_record_id IS NOT NULL;
    SQL

    # 3. Indexar los nuevos campos para búsquedas rápidas
    add_index :email_logs, :campaign_uuid unless index_exists?(:email_logs, :campaign_uuid)
    add_index :email_logs, :email_record_uuid unless index_exists?(:email_logs, :email_record_uuid)
  end

  def down
    remove_index :email_logs, :campaign_uuid if index_exists?(:email_logs, :campaign_uuid)
    remove_index :email_logs, :email_record_uuid if index_exists?(:email_logs, :email_record_uuid)
    remove_column :email_logs, :campaign_uuid if column_exists?(:email_logs, :campaign_uuid)
    remove_column :email_logs, :email_record_uuid if column_exists?(:email_logs, :email_record_uuid)
  end
end
