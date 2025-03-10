class CreateCreditAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :credit_accounts do |t|
      t.integer :available_credit
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
