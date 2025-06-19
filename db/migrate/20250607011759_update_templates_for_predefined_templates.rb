class UpdateTemplatesForPredefinedTemplates < ActiveRecord::Migration[8.0]
  def change
    remove_column :templates, :content, :text   # Eliminamos el campo viejo
    add_column :templates, :preview_image_url, :string
    change_column_null :templates, :user_id, true # Ahora puede ser nulo para plantillas globales
  end
end
