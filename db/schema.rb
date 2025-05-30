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

ActiveRecord::Schema[8.0].define(version: 2025_05_30_073915) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bad_events", force: :cascade do |t|
    t.string "bad_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0, null: false
  end

  create_table "contract_basics", force: :cascade do |t|
    t.string "upload_file_id", comment: "Dify 上传完毕后拿到的文件 ID"
    t.string "contract_type", comment: "合同类型"
    t.string "contract_nature", comment: "合同性质"
    t.string "east_boundary", comment: "东至"
    t.string "south_boundary", comment: "南至"
    t.string "west_boundary", comment: "西至"
    t.string "north_boundary", comment: "北至"
    t.string "contract_name", comment: "合同名称"
    t.string "project_land_use_nature", comment: "项目用地性质"
    t.string "currency", limit: 10, comment: "币种"
    t.decimal "contract_amount", precision: 18, scale: 2, comment: "合同金额"
    t.decimal "split_contract_amount", precision: 18, scale: 2, comment: "切分合同金额"
    t.decimal "actual_contract_amount", precision: 18, scale: 2, comment: "实际合同额"
    t.string "party_a", comment: "甲方"
    t.string "party_b", comment: "乙方"
    t.string "scale_type", comment: "规模类型"
    t.decimal "scale_area", precision: 18, scale: 2, comment: "规模面积"
    t.string "beneficiary_bank_account", comment: "收款银行账户"
    t.string "beneficiary_bank", comment: "收款开户行"
    t.boolean "is_epc", comment: "是否EPC"
    t.boolean "is_design_general_contractor", comment: "是否设计总承包"
    t.string "project_tag", comment: "项目标签"
    t.string "quotation_method", comment: "报价方式"
    t.decimal "construction_and_installation_fee", precision: 18, scale: 2, comment: "工程建安费"
    t.decimal "discount_rate", precision: 5, scale: 4, comment: "下浮系数"
    t.string "developer_name", comment: "建设方名称"
    t.string "developer_type", comment: "建设方类型"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "upload_filename"
  end

  create_table "contract_reviews", force: :cascade do |t|
    t.bigint "contract_basic_id", null: false
    t.string "scope_business", comment: "岩土工程设计,市政工程,交通工程设计,勘察,以上都不包含"
    t.boolean "curtain_wall_cert_usage", comment: "幕墙资质使用"
    t.boolean "epc_lead_role", comment: "EPC总牵头人"
    t.boolean "first_payment_prepayment", comment: "首笔预付款"
    t.boolean "fee_adjustment_downward_only", comment: "费用只调减"
    t.string "danger_payment_specified", comment: "商业承兑汇票,有追索权的保理,抵房,无追索权的保理,以上都不包含"
    t.boolean "prohibited_split", comment: "是否违反以下条款：对于大型开发项目或多地块项目，施工图或总包项目要在合同中约定分期开发、分期结算"
    t.decimal "final_payment_rate", precision: 5, scale: 2, comment: "尾款：施工图审批通过后或立面控制手册完成后收款比例"
    t.boolean "penalty_staff_replacement", comment: "人员更换罚款"
    t.decimal "penalty_amount", precision: 12, scale: 2, comment: "罚款金额"
    t.boolean "work_suspension_prohibited", comment: "禁止暂停工作"
    t.boolean "liability_cap_twice_contract", comment: "责任上限2倍"
    t.boolean "cross_contract_penalty_prohibited", comment: "禁止跨合同扣款"
    t.boolean "liability_clause_keywords", comment: "责任条款字眼:乙方应承担甲方的一切损失,乙方应承担甲方利润,乙方应承担甲方的工程,乙方应承担甲方的间接损失,乙方应承担甲方的维权费用,以上都不包含"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_basic_id"], name: "index_contract_reviews_on_contract_basic_id"
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

  add_foreign_key "contract_reviews", "contract_basics"
  add_foreign_key "user_bad_events", "bad_events"
  add_foreign_key "user_bad_events", "users"
  add_foreign_key "user_good_events", "good_events"
  add_foreign_key "user_good_events", "users"
  add_foreign_key "user_job_roles", "job_roles"
  add_foreign_key "user_job_roles", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
