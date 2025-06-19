class AddUserUuidToAssociations < ActiveRecord::Migration[8.0]
  def up
    # Añade la columna user_uuid a las tablas relacionadas
    add_column :campaigns, :user_uuid, :uuid
    add_column :templates, :user_uuid, :uuid
    add_column :transactions, :user_uuid, :uuid
    add_column :email_blocks, :user_uuid, :uuid

    # Copia los valores de uuid desde users a las nuevas columnas
    execute <<-SQL
      UPDATE campaigns SET user_uuid = users.uuid FROM users WHERE campaigns.user_id = users.id;
      UPDATE templates SET user_uuid = users.uuid FROM users WHERE templates.user_id = users.id;
      UPDATE transactions SET user_uuid = users.uuid FROM users WHERE transactions.user_id = users.id;
      UPDATE email_blocks SET user_uuid = users.uuid FROM users WHERE email_blocks.user_id = users.id;
    SQL

    # Añade índices para optimizar consultas
    add_index :campaigns, :user_uuid
    add_index :templates, :user_uuid
    add_index :transactions, :user_uuid
    add_index :email_blocks, :user_uuid
  end

  def down
    # Elimina las columnas si se hace rollback
    remove_column :campaigns, :user_uuid
    remove_column :templates, :user_uuid
    remove_column :transactions, :user_uuid
    remove_column :email_blocks, :user_uuid
  end
end
