class CreatePublicEmailRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :public_email_records do |t|
      t.string :email
      t.string :website
      t.string :address
      t.string :municipality
      t.string :city
      t.string :country
      t.string :company_name
      t.text :description
      t.string :industry

      t.timestamps
    end
  end
end
