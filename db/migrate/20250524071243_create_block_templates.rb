class CreateBlockTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :block_templates do |t|
      t.string :name
      t.text :description
      t.text :html_content
      t.string :category
      t.jsonb :settings
      t.boolean :public
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
