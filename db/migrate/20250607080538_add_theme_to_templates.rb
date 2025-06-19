class AddThemeToTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :templates, :theme, :string, null: false, default: ""
  end
end
