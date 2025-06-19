class AddUuidToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :templates, :uuid, unique: true
  end
end
