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

ActiveRecord::Schema[8.1].define(version: 2026_01_08_001849) do
  create_table "leads", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.string "email"
    t.decimal "lat", precision: 10, scale: 6
    t.decimal "long", precision: 10, scale: 6
    t.string "name"
    t.string "phone"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_leads_on_deleted_at"
    t.index ["email"], name: "index_leads_on_email"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.text "description"
    t.string "name"
    t.decimal "price"
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["name"], name: "index_products_on_name"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.integer "lead_id", null: false
    t.integer "product_id", null: false
    t.string "status"
    t.string "svc_code"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["deleted_at"], name: "index_projects_on_deleted_at"
    t.index ["lead_id"], name: "index_projects_on_lead_id"
    t.index ["product_id"], name: "index_projects_on_product_id"
    t.index ["svc_code"], name: "index_projects_on_svc_code"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "sales_targets", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.integer "month"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "users", force: :cascade do |t|
    t.text "ban_reason"
    t.boolean "banned"
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.string "role"
    t.datetime "updated_at", null: false
    t.string "username"
    t.datetime "verified_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "projects", "leads"
  add_foreign_key "projects", "products"
  add_foreign_key "projects", "users"
end
