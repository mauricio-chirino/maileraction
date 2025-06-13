class AddUuidToSupportRequests < ActiveRecord::Migration[8.0]
  def up
    add_column :support_requests, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :support_requests, :uuid, unique: true
  end

  def down
    remove_column :support_requests, :uuid
  end
end
