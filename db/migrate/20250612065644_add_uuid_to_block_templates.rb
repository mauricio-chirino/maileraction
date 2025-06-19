class AddUuidToBlockTemplates < ActiveRecord::Migration[8.0]
  def up
    add_column :block_templates, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :block_templates, :uuid, unique: true
    # Copiar uuid a email_blocks
    add_column :email_blocks, :block_template_uuid, :uuid
    execute "UPDATE email_blocks SET block_template_uuid = block_templates.uuid FROM block_templates WHERE email_blocks.block_template_id = block_templates.id;"
    add_index :email_blocks, :block_template_uuid
  end

  def down
    remove_column :email_blocks, :block_template_uuid
    remove_column :block_templates, :uuid
  end
end
