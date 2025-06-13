class AddUuidToEmailBlocks < ActiveRecord::Migration[8.0]
  def change
    add_column :email_blocks, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :email_blocks, :uuid, unique: true
  end
end
