class AddPublicToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :public, :boolean
  end
end
