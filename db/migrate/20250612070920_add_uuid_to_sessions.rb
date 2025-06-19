class AddUuidToSessions < ActiveRecord::Migration[8.0]
  def up
    add_column :sessions, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :sessions, :uuid, unique: true
  end

  def down
    remove_column :sessions, :uuid
  end
end
