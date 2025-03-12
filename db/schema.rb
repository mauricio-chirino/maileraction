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

ActiveRecord::Schema[8.0].define(version: 2025_03_12_044642) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bounces", force: :cascade do |t|
    t.string "reason"
    t.datetime "bounced_at"
    t.bigint "email_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_record_id"], name: "index_bounces_on_email_record_id"
  end

  create_table "campaign_emails", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.bigint "email_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_campaign_emails_on_campaign_id"
    t.index ["email_record_id"], name: "index_campaign_emails_on_email_record_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "email_limit"
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_campaigns_on_industry_id"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "credit_accounts", force: :cascade do |t|
    t.integer "available_credit"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credit_accounts_on_user_id"
  end

  create_table "email_logs", force: :cascade do |t|
    t.string "status"
    t.datetime "opened_at"
    t.datetime "clicked_at"
    t.bigint "campaign_id", null: false
    t.bigint "email_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_email_logs_on_campaign_id"
    t.index ["email_record_id"], name: "index_email_logs_on_email_record_id"
  end

  create_table "email_records", force: :cascade do |t|
    t.string "email"
    t.string "company"
    t.string "website"
    t.bigint "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["industry_id"], name: "index_email_records_on_industry_id"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.integer "email_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.integer "max"
    t.integer "campaigna"
    t.integer "max_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
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

  create_table "transactions", force: :cascade do |t|
    t.integer "amount"
    t.string "status"
    t.string "payment_method"
    t.bigint "user_id", null: false
    t.bigint "credit_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["plan_id"], name: "index_users_on_plan_id"
  end

  add_foreign_key "bounces", "email_records"
  add_foreign_key "campaign_emails", "campaigns"
  add_foreign_key "campaign_emails", "email_records"
  add_foreign_key "campaigns", "industries"
  add_foreign_key "campaigns", "users"
  add_foreign_key "credit_accounts", "users"
  add_foreign_key "email_logs", "campaigns"
  add_foreign_key "email_logs", "email_records"
  add_foreign_key "email_records", "industries"
  add_foreign_key "sessions", "users"
  add_foreign_key "transactions", "credit_accounts"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "plans"
end
