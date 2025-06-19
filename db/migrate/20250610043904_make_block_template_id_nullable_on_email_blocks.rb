class MakeBlockTemplateIdNullableOnEmailBlocks < ActiveRecord::Migration[8.0]
  def change
    change_column_null :email_blocks, :block_template_id, true
  end
end
