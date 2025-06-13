class AddUuidToNotifications < ActiveRecord::Migration[8.0]
  def up
    add_column :notifications, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :notifications, :uuid, unique: true
  end

  def down
    remove_column :notifications, :uuid
  end
end
