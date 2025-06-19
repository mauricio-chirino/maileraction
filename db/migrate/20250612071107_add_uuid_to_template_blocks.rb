class AddUuidToTemplateBlocks < ActiveRecord::Migration[8.0]
  def up
    add_column :template_blocks, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :template_blocks, :uuid, unique: true
  end

  def down
    remove_column :template_blocks, :uuid
  end
end
