class AddBlockTemplateUuidToEmailBlocks < ActiveRecord::Migration[8.0]
  def up
    add_column :block_templates, :user_uuid, :uuid unless column_exists?(:block_templates, :user_uuid)

    execute <<-SQL
      UPDATE block_templates
      SET user_uuid = users.uuid
      FROM users
      WHERE block_templates.user_id = users.id;
    SQL

    add_index :block_templates, :user_uuid unless index_exists?(:block_templates, :user_uuid)

    # El bloque para email_blocks
    # add_column :email_blocks, :block_template_uuid, :uuid unless column_exists?(:email_blocks, :block_template_uuid)

    execute <<-SQL
      UPDATE email_blocks
      SET block_template_uuid = block_templates.uuid
      FROM block_templates
      WHERE email_blocks.block_template_id = block_templates.id;
    SQL

    # SOLO SI EL ÍNDICE NO EXISTE:
    # add_index :email_blocks, :block_template_uuid unless index_exists?(:email_blocks, :block_template_uuid)
  end

  def down
    remove_column :block_templates, :user_uuid if column_exists?(:block_templates, :user_uuid)
    # remove_column :email_blocks, :block_template_uuid if column_exists?(:email_blocks, :block_template_uuid)
  end
end
