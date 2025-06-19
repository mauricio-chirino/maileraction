class AddUserUuidToSessions < ActiveRecord::Migration[8.0]
  def up
    # 1. Añade la columna user_uuid (uuid)
    add_column :sessions, :user_uuid, :uuid

    # 2. Llena los valores usando el mapeo actual de User
    execute <<-SQL.squish
      UPDATE sessions SET user_uuid = users.uuid FROM users WHERE sessions.user_id = users.id;
    SQL

    # 3. Agrega índice (opcional pero recomendado)
    add_index :sessions, :user_uuid

    # (Opcional) Si quieres quitar user_id, solo después de actualizar todos los modelos/controladores:
    # remove_column :sessions, :user_id
  end

  def down
    remove_index :sessions, :user_uuid
    remove_column :sessions, :user_uuid
    # Si quitaste user_id, recuerda añadirlo de nuevo aquí.
  end
end
