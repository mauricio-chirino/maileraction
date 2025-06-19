class AddUuidToEmailRecords < ActiveRecord::Migration[8.0]
  def up
    # 1. Agregar uuid a email_records
    add_column :email_records, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index  :email_records, :uuid, unique: true

    # 2. Agregar email_record_uuid en tablas que SI tienen FK a email_records
    add_column :email_logs,      :email_record_uuid, :uuid
    add_column :campaign_emails, :email_record_uuid, :uuid
    add_column :bounces,         :email_record_uuid, :uuid

    # 3. Poblar los nuevos campos uuid en asociaciones existentes
    execute <<-SQL.squish
      UPDATE email_logs
      SET email_record_uuid = email_records.uuid
      FROM email_records
      WHERE email_logs.email_record_id = email_records.id;
    SQL

    execute <<-SQL.squish
      UPDATE campaign_emails
      SET email_record_uuid = email_records.uuid
      FROM email_records
      WHERE campaign_emails.email_record_id = email_records.id;
    SQL

    execute <<-SQL.squish
      UPDATE bounces
      SET email_record_uuid = email_records.uuid
      FROM email_records
      WHERE bounces.email_record_id = email_records.id;
    SQL

    # 4. Indexar los nuevos campos si lo deseas (opcional pero recomendado)
    add_index :email_logs,      :email_record_uuid
    add_index :campaign_emails, :email_record_uuid
    add_index :bounces,         :email_record_uuid
  end

  def down
    remove_index :bounces,         :email_record_uuid
    remove_index :campaign_emails, :email_record_uuid
    remove_index :email_logs,      :email_record_uuid

    remove_column :bounces,         :email_record_uuid
    remove_column :campaign_emails, :email_record_uuid
    remove_column :email_logs,      :email_record_uuid

    remove_index  :email_records, :uuid
    remove_column :email_records, :uuid
  end
end
