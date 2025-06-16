class AddUserUuidToSupportRequests < ActiveRecord::Migration[8.0]
  def up
    add_column :support_requests, :user_uuid, :uuid

    # Backfill: Copia los UUIDs desde users a support_requests
    execute <<-SQL.squish
      UPDATE support_requests
      SET user_uuid = users.uuid
      FROM users
      WHERE support_requests.user_id = users.id
    SQL

    add_index :support_requests, :user_uuid
  end

  def down
    remove_index :support_requests, :user_uuid
    remove_column :support_requests, :user_uuid
  end
end
