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

ActiveRecord::Schema[8.0].define(version: 2024_11_15_082525) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bad_events", force: :cascade do |t|
    t.string "bad_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0, null: false
  end

  create_table "good_events", force: :cascade do |t|
    t.string "good_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0, null: false
  end

  create_table "job_roles", force: :cascade do |t|
    t.string "st_code"
    t.integer "job_level"
    t.string "job_code"
    t.string "job_family"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_bad_events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "bad_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bad_event_id"], name: "index_user_bad_events_on_bad_event_id"
    t.index ["user_id"], name: "index_user_bad_events_on_user_id"
  end

  create_table "user_good_events", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "good_event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["good_event_id"], name: "index_user_good_events_on_good_event_id"
    t.index ["user_id"], name: "index_user_good_events_on_user_id"
  end

  create_table "user_job_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_role_id", null: false
    t.bigint "manager_user_id"
    t.string "company"
    t.string "department"
    t.string "dept_code"
    t.string "title"
    t.string "job_user_id"
    t.boolean "is_active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_role_id"], name: "index_user_job_roles_on_job_role_id"
    t.index ["manager_user_id"], name: "index_user_job_roles_on_manager_user_id"
    t.index ["user_id"], name: "index_user_job_roles_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "preferred_language"
    t.integer "preferred_page_length", default: 10, null: false
    t.string "chinese_name", null: false
    t.date "hire_date", null: false
    t.string "clerk_code", null: false
    t.boolean "is_active", default: false, null: false
    t.boolean "sidebar_narrow", default: false, null: false
    t.integer "good_events_count", default: 0, null: false
    t.integer "bad_events_count", default: 0, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_bad_events", "bad_events"
  add_foreign_key "user_bad_events", "users"
  add_foreign_key "user_good_events", "good_events"
  add_foreign_key "user_good_events", "users"
  add_foreign_key "user_job_roles", "job_roles"
  add_foreign_key "user_job_roles", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
