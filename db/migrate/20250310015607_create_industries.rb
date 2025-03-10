class CreateIndustries < ActiveRecord::Migration[8.0]
  def change
    create_table :industries do |t|
      t.string :name
      t.integer :email_count

      t.timestamps
    end
  end
end
