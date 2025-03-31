class AddNameEnToIndustries < ActiveRecord::Migration[8.0]
  def change
    add_column :industries, :name_en, :string
  end
end
