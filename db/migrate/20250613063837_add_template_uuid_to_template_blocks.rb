class AddTemplateUuidToTemplateBlocks < ActiveRecord::Migration[8.0]
  def up
    # 1. Agrega la columna UUID (si no existe ya)
    add_column :template_blocks, :template_uuid, :uuid

    # 2. Rellena los valores usando el join por FK actual
    execute <<-SQL
      UPDATE template_blocks
      SET template_uuid = templates.uuid
      FROM templates
      WHERE template_blocks.template_id = templates.id
    SQL

    # 3. Crea el índice para la nueva columna FK
    add_index :template_blocks, :template_uuid

    # (Opcional) 4. Si decides dejar de usar template_id más adelante, puedes quitarla en una migración posterior
    # remove_column :template_blocks, :template_id
  end

  def down
    remove_index :template_blocks, :template_uuid
    remove_column :template_blocks, :template_uuid
  end
end
