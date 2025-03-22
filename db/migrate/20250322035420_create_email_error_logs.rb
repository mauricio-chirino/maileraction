class CreateEmailErrorLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :email_error_logs do |t|
      t.string :email
      t.bigint :campaign_id
      t.text :error

      t.timestamps
    end
  end
end
