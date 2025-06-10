# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_07_080538) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "block_templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "html_content"
    t.string "category"
    t.jsonb "settings"
    t.boolean "public"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_block_templates_on_user_id"
  end

  create_table "bounces", force: :cascade do |t|
    t.string "reason"
    t.datetime "bounced_at"
    t.bigint "email_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campaign_id"
    t.uuid "campaign_uuid"
    t.index ["campaign_id"], name: "index_bounces_on_campaign_id"
    t.index ["campaign_uuid"], name: "index_bounces_on_campaign_uuid"
    t.index ["email_record_id"], name: "index_bounces_on_email_record_id"
  end

  create_table "campaign_emails", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "email_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "campaign_uuid"
    t.index ["campaign_id"], name: "index_campaign_emails_on_campaign_id"
    t.index ["campaign_uuid"], name: "index_campaign_emails_on_campaign_uuid"
    t.index ["email_record_id"], name: "index_campaign_emails_on_email_record_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "email_limit"
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.text "body"
    t.bigint "template_id"
    t.datetime "send_at"
    t.text "html_content"
    t.string "name"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.boolean "canvas_cleared"
    t.index ["industry_id"], name: "index_campaigns_on_industry_id"
    t.index ["template_id"], name: "index_campaigns_on_template_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
    t.index ["uuid"], name: "index_campaigns_on_uuid", unique: true
  end

  create_table "credit_accounts", force: :cascade do |t|
    t.integer "available_credit"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credit_accounts_on_user_id"
  end

  create_table "email_blocks", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "user_id", null: false
    t.bigint "block_template_id", null: false
    t.string "name"
    t.string "block_type"
    t.text "html_content"
    t.jsonb "settings"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "campaign_uuid"
    t.index ["block_template_id"], name: "index_email_blocks_on_block_template_id"
    t.index ["campaign_id"], name: "index_email_blocks_on_campaign_id"
    t.index ["campaign_uuid"], name: "index_email_blocks_on_campaign_uuid"
    t.index ["user_id"], name: "index_email_blocks_on_user_id"
  end

  create_table "email_error_logs", force: :cascade do |t|
    t.string "email"
    t.bigint "campaign_id"
    t.text "error"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "campaign_uuid"
    t.index ["campaign_uuid"], name: "index_email_error_logs_on_campaign_uuid"
  end

  create_table "email_event_logs", force: :cascade do |t|
    t.string "email", null: false
    t.string "event_type", null: false
    t.jsonb "metadata", default: {}
    t.bigint "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "campaign_uuid"
    t.index ["campaign_id"], name: "index_email_event_logs_on_campaign_id"
    t.index ["campaign_uuid"], name: "index_email_event_logs_on_campaign_uuid"
    t.index ["email"], name: "index_email_event_logs_on_email"
    t.index ["event_type"], name: "index_email_event_logs_on_event_type"
  end

  create_table "email_logs", force: :cascade do |t|
    t.string "status"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.bigint "campaign_id", null: false
    t.bigint "email_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "credit_refunded", default: false
    t.integer "attempts_count"
    t.uuid "campaign_uuid"
    t.index ["campaign_id"], name: "index_email_logs_on_campaign_id"
    t.index ["campaign_uuid"], name: "index_email_logs_on_campaign_uuid"
    t.index ["email_record_id"], name: "index_email_logs_on_email_record_id"
  end

  create_table "email_records", force: :cascade do |t|
    t.string "email"
    t.string "company"
    t.string "website"
    t.bigint "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bounces_count"
    t.boolean "active"
    t.index ["industry_id"], name: "index_email_records_on_industry_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.integer "email_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "read_at"
    t.datetime "email_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "max"
    t.integer "campaigna"
    t.integer "max_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "public_email_records", force: :cascade do |t|
    t.string "email"
    t.string "website"
    t.string "address"
    t.string "municipality"
    t.string "city"
    t.string "country"
    t.string "company_name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "industry_id", null: false
    t.string "source_keyword"
    t.integer "status", default: 0, null: false
    t.index ["industry_id"], name: "index_public_email_records_on_industry_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scrape_targets", force: :cascade do |t|
    t.string "url"
    t.integer "status"
    t.datetime "last_attempt_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scraping_sources", force: :cascade do |t|
    t.string "url"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "session_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.index ["session_token"], name: "index_sessions_on_session_token"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["name", "supervisor_id"], name: "index_solid_queue_processes_on_name_and_supervisor_id", unique: true
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "task_key", null: false
    t.datetime "run_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_recurring_tasks", force: :cascade do |t|
    t.string "key", null: false
    t.string "schedule", null: false
    t.string "command", limit: 2048
    t.string "class_name"
    t.text "arguments"
    t.string "queue_name"
    t.integer "priority", default: 0
    t.boolean "static", default: true, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_solid_queue_recurring_tasks_on_key", unique: true
    t.index ["static"], name: "index_solid_queue_recurring_tasks_on_static"
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "support_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category"
    t.integer "status"
    t.integer "priority"
    t.integer "source"
    t.index ["user_id"], name: "index_support_requests_on_user_id"
  end

  create_table "template_blocks", force: :cascade do |t|
    t.bigint "template_id", null: false
    t.string "block_type", null: false
    t.text "html_content", null: false
    t.jsonb "settings"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_template_blocks_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "category"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public"
    t.string "preview_image_url"
    t.text "html_content"
    t.string "theme", default: "", null: false
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "amount"
    t.string "status"
    t.string "payment_method"
    t.bigint "user_id", null: false
    t.bigint "credit_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "campaign_id"
    t.uuid "campaign_uuid"
    t.index ["campaign_id"], name: "index_transactions_on_campaign_id"
    t.index ["campaign_uuid"], name: "index_transactions_on_campaign_uuid"
    t.index ["credit_account_id"], name: "index_transactions_on_credit_account_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 4, null: false
    t.bigint "plan_id"
    t.string "time_zone"
    t.string "remember_token"
    t.string "company"
    t.string "name"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.index ["plan_id"], name: "index_users_on_plan_id"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "block_templates", "users"
  add_foreign_key "bounces", "campaigns"
  add_foreign_key "bounces", "email_records"
  add_foreign_key "campaign_emails", "campaigns"
  add_foreign_key "campaign_emails", "email_records"
  add_foreign_key "campaigns", "industries"
  add_foreign_key "campaigns", "templates"
  add_foreign_key "campaigns", "users"
  add_foreign_key "credit_accounts", "users"
  add_foreign_key "email_blocks", "block_templates"
  add_foreign_key "email_blocks", "campaigns"
  add_foreign_key "email_blocks", "users"
  add_foreign_key "email_event_logs", "campaigns"
  add_foreign_key "email_logs", "campaigns"
  add_foreign_key "email_logs", "email_records"
  add_foreign_key "email_records", "industries"
  add_foreign_key "notifications", "users"
  add_foreign_key "public_email_records", "industries"
  add_foreign_key "sessions", "users"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "support_requests", "users"
  add_foreign_key "template_blocks", "templates"
  add_foreign_key "templates", "users"
  add_foreign_key "transactions", "campaigns"
  add_foreign_key "transactions", "credit_accounts"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "plans"
end
