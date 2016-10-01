# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161001162438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "benefit_details", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "employee_category"
    t.string   "benefit_category"
    t.string   "benefit_method"
    t.string   "benefit_amount"
    t.integer  "benefit_profile_id"
    t.decimal  "category_sub"
    t.decimal  "category_dep"
    t.decimal  "category_sps"
    t.decimal  "category_ch_pls_one"
    t.decimal  "category_sps_pls_one"
    t.string   "employee_tier"
  end

  create_table "benefit_profiles", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "provider"
    t.string   "provider_plan"
    t.string   "benefit_type"
    t.string   "benefit_method"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone_number"
    t.string   "federal_id_number"
    t.string   "state_wh_number"
    t.string   "unemployment_number"
    t.string   "processor_name"
    t.string   "pay_frequency"
    t.string   "timework_id"
    t.string   "timework_pass"
  end

  create_table "employee_additional_logins", force: :cascade do |t|
    t.string   "subscriber_id"
    t.string   "swipeclock_ee_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "employee_id"
  end

  create_table "employee_benefits", force: :cascade do |t|
    t.decimal  "pto_balance"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ee_id"
    t.string   "employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "email"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone_number"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sub_id"
    t.date     "date_of_birth"
    t.date     "date_of_hire"
  end

  create_table "health_invoices", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "account_number"
    t.string   "billing_profile"
    t.integer  "category"
    t.string   "product"
    t.string   "health_sub_id"
    t.string   "sub_name"
    t.string   "tier"
    t.string   "change_reason"
    t.decimal  "retro_fee_adjustment"
    t.decimal  "current_charges"
    t.decimal  "total_charges"
    t.integer  "month"
    t.integer  "year"
  end

  create_table "payroll_deductions", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "pay_ee_id"
    t.string   "pay_sub_id"
    t.string   "pay_sub_name"
    t.string   "pay_category"
    t.decimal  "deduction_amount"
  end

  create_table "payroll_periods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "pay_period"
    t.integer  "year"
    t.integer  "month"
    t.integer  "day"
    t.integer  "company_id"
  end

  create_table "reconciliations", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeworks", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "company_id"
    t.string   "user_id"
    t.string   "password"
    t.string   "secondFactor"
    t.string   "client_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
