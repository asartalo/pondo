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

ActiveRecord::Schema.define(version: 20170811200730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "categories", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.text "description"
    t.uuid "ledger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_categories_on_ledger_id"
  end

  create_table "country_currencies", id: :serial, force: :cascade do |t|
    t.string "country_code"
    t.string "currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_code"], name: "index_country_currencies_on_country_code"
    t.index ["currency"], name: "index_country_currencies_on_currency"
  end

  create_table "ledger_subscribers", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.uuid "ledger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_ledger_subscribers_on_ledger_id"
    t.index ["user_id", "ledger_id"], name: "index_ledger_subscribers_on_user_id_and_ledger_id", unique: true
    t.index ["user_id"], name: "index_ledger_subscribers_on_user_id"
  end

  create_table "ledgers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "name"
    t.string "currency"
    t.integer "savings_target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_ledgers_on_user_id"
  end

  create_table "money_move_types", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "ledger_id"
    t.uuid "category_id"
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_money_move_types_on_category_id"
    t.index ["ledger_id"], name: "index_money_move_types_on_ledger_id"
  end

  create_table "money_moves", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.date "date"
    t.decimal "amount", precision: 14, scale: 4
    t.text "notes"
    t.string "type"
    t.uuid "ledger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "money_move_type_id"
    t.index ["date"], name: "index_money_moves_on_date"
    t.index ["ledger_id"], name: "index_money_moves_on_ledger_id"
    t.index ["money_move_type_id"], name: "index_money_moves_on_money_move_type_id"
  end

  create_table "subscriptions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.boolean "done"
    t.uuid "ledger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_subscriptions_on_ledger_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", default: "", null: false
    t.string "provider", default: "", null: false
    t.string "uid", default: "", null: false
    t.string "image", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "categories", "ledgers"
  add_foreign_key "ledger_subscribers", "ledgers"
  add_foreign_key "ledger_subscribers", "users"
  add_foreign_key "ledgers", "users"
  add_foreign_key "money_move_types", "categories"
  add_foreign_key "money_move_types", "ledgers"
  add_foreign_key "money_moves", "ledgers"
  add_foreign_key "money_moves", "money_move_types"
  add_foreign_key "subscriptions", "ledgers"
end
