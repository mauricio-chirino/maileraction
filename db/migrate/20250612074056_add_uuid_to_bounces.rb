class AddUuidToBounces < ActiveRecord::Migration[8.0]
  def up
    add_column :bounces, :uuid, :uuid, default: "gen_random_uuid()", null: false unless column_exists?(:bounces, :uuid)
    add_index :bounces, :uuid, unique: true unless index_exists?(:bounces, :uuid)
    # Bounce.reset_column_information
    # Bounce.where(uuid: nil).find_each { |b| b.update_column(:uuid, SecureRandom.uuid) }
  end
  def down
    remove_index :bounces, :uuid if index_exists?(:bounces, :uuid)
    remove_column :bounces, :uuid if column_exists?(:bounces, :uuid)
  end
end
