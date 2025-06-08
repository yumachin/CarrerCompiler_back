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

ActiveRecord::Schema[8.0].define(version: 2025_06_08_034151) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", default: "", null: false
    t.integer "industry", default: 0, null: false
    t.integer "employees", default: 0, null: false
    t.string "website", default: "", null: false
    t.string "address", default: "", null: false
    t.integer "income", default: 0, null: false
    t.integer "holidays", default: 0, null: false
    t.string "working_hours", default: "", null: false
    t.string "other", default: "", null: false
    t.boolean "favorite", default: false, null: false
    t.text "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "interviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "date"
    t.integer "selection_id", default: 0, null: false
    t.string "interview_type", default: "", null: false
    t.string "online_url", default: "", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_interviews_on_company_id"
    t.index ["user_id"], name: "index_interviews_on_user_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "date"
    t.string "meeting_type", default: "", null: false
    t.string "online_url", default: "", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_meetings_on_company_id"
    t.index ["user_id"], name: "index_meetings_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "deadline"
    t.integer "submission_type", default: 0, null: false
    t.boolean "status", default: false, null: false
    t.string "contact_media", default: "", null: false
    t.string "submission_url", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_submissions_on_company_id"
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "companies", "users"
  add_foreign_key "interviews", "companies"
  add_foreign_key "interviews", "users"
  add_foreign_key "meetings", "companies"
  add_foreign_key "meetings", "users"
  add_foreign_key "submissions", "companies"
  add_foreign_key "submissions", "users"
end
