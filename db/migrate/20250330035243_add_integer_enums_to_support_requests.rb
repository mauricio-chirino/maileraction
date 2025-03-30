class AddIntegerEnumsToSupportRequests < ActiveRecord::Migration[8.0]
  def up
    mapping = {
      category: { "bug" => 0, "idea" => 1, "question" => 2 },
      status:   { "open" => 0, "in_progress" => 1, "resolved" => 2 },
      priority: { "low" => 0, "medium" => 1, "high" => 2 },
      source:   { "web" => 0, "mobile" => 1, "internal" => 2 }
    }

    SupportRequest.reset_column_information
    SupportRequest.find_each do |request|
      request.update_columns(
        category_int: mapping[:category][request.category],
        status_int:   mapping[:status][request.status],
        priority_int: mapping[:priority][request.priority],
        source_int:   mapping[:source][request.source]
      )
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
