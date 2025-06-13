class AddUuidToCreditAccounts < ActiveRecord::Migration[8.0]
  def up
    add_column :credit_accounts, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :credit_accounts, :uuid, unique: true
    add_column :transactions, :credit_account_uuid, :uuid
    execute "UPDATE transactions SET credit_account_uuid = credit_accounts.uuid FROM credit_accounts WHERE transactions.credit_account_id = credit_accounts.id;"
    add_index :transactions, :credit_account_uuid
  end

  def down
    remove_column :transactions, :credit_account_uuid
    remove_column :credit_accounts, :uuid
  end
end
