class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :max
      t.integer :campaigna
      t.integer :max_email

      t.timestamps
    end
  end
end
