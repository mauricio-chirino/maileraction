class AddPriorityAndSourceToSupportRequests < ActiveRecord::Migration[8.0]
  def change
    add_column :support_requests, :priority, :string, default: "low"
    add_column :support_requests, :source, :string, default: "web"
  end
end
