class CreateEmailRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :email_records do |t|
      t.string :email
      t.string :company
      t.string :website
      t.references :industry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
