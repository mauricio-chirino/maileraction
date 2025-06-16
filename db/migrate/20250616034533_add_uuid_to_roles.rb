class AddUuidToRoles < ActiveRecord::Migration[8.0]
  def change
    add_column :roles, :uuid, :uuid, default: -> { "gen_random_uuid()" }, null: false
    add_index :roles, :uuid, unique: true
  end
end
