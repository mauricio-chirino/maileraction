class CreateBounces < ActiveRecord::Migration[8.0]
  def change
    create_table :bounces do |t|
      t.string :reason
      t.datetime :bounced_at
      t.references :email_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
