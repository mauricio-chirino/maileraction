class CreateTemplateBlocks < ActiveRecord::Migration[8.0]
    def change
    create_table :template_blocks do |t|
      t.references :template, null: false, foreign_key: true
      t.string :block_type, null: false
      t.text :html_content, null: false
      t.jsonb :settings
      t.integer :position
      t.timestamps
    end
  end
end
