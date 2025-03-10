class CreateEmailLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :email_logs do |t|
      t.string :status
      t.datetime :opened_at
      t.datetime :clicked_at
      t.references :campaign, null: false, foreign_key: true
      t.references :email_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
