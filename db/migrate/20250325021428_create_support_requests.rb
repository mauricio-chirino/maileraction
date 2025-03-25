class CreateSupportRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :support_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.text :message, null: false
      t.string :category, null: false
      t.string :status, default: "open"

      t.timestamps
    end
  end
end
