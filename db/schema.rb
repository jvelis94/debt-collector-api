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

ActiveRecord::Schema.define(version: 2021_09_05_151606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_items", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.bigint "bill_recipient_id", null: false
    t.string "item_name"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity", default: 1
    t.integer "total"
    t.index ["bill_id"], name: "index_bill_items_on_bill_id"
    t.index ["bill_recipient_id"], name: "index_bill_items_on_bill_recipient_id"
  end

  create_table "bill_recipients", force: :cascade do |t|
    t.bigint "bill_id", null: false
    t.string "recipient_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_owes", default: 0
    t.integer "total_paid", default: 0
    t.integer "tax", default: 0
    t.integer "subtotal", default: 0
    t.integer "gratuity", default: 0
    t.index ["bill_id"], name: "index_bill_recipients_on_bill_id"
  end

  create_table "bills", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bill_name"
    t.boolean "isFulfilled", default: false
    t.integer "total_amount", default: 0
    t.integer "subtotal", default: 0
    t.integer "tax", default: 0
    t.float "gratuity", default: 0.18
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bill_items", "bill_recipients"
  add_foreign_key "bill_items", "bills"
  add_foreign_key "bill_recipients", "bills"
  add_foreign_key "bills", "users"
end
