class AddIndustryUuidToPublicEmailRecords < ActiveRecord::Migration[8.0]
  def up
    add_column :public_email_records, :industry_uuid, :uuid

    # Poblar la columna industry_uuid con el uuid real
    execute <<-SQL
      UPDATE public_email_records
      SET industry_uuid = industries.uuid
      FROM industries
      WHERE public_email_records.industry_id = industries.id;
    SQL

    add_index :public_email_records, :industry_uuid
  end

  def down
    remove_column :public_email_records, :industry_uuid
  end
end
