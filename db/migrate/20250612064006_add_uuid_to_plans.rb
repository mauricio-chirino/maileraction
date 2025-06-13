class AddUuidToPlans < ActiveRecord::Migration[8.0]
  def up
    add_column :plans, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_index :plans, :uuid, unique: true
    # Copiar uuid a users
    add_column :users, :plan_uuid, :uuid
    execute "UPDATE users SET plan_uuid = plans.uuid FROM plans WHERE users.plan_id = plans.id;"
    add_index :users, :plan_uuid
  end

  def down
    remove_column :users, :plan_uuid
    remove_column :plans, :uuid
  end
end
