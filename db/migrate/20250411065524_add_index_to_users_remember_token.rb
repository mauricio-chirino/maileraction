class AddIndexToUsersRememberToken < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :remember_token, unique: true
  end
end
