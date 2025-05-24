class CreateEmailBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :email_blocks do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :block_template, null: false, foreign_key: true
      t.string :name
      t.string :block_type
      t.text :html_content
      t.jsonb :settings
      t.integer :position

      t.timestamps
    end
  end
end
