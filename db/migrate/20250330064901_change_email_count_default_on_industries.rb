class ChangeEmailCountDefaultOnIndustries < ActiveRecord::Migration[8.0]
  def change
    change_column_default :industries, :email_count, from: nil, to: 0
  end
end
