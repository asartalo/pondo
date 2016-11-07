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

ActiveRecord::Schema.define(version: 20161107111129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "ledger_subscribers", force: :cascade do |t|
    t.integer  "user_id"
    t.uuid     "ledger_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ledger_id"], name: "index_ledger_subscribers_on_ledger_id", using: :btree
    t.index ["user_id", "ledger_id"], name: "index_ledger_subscribers_on_user_id_and_ledger_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_ledger_subscribers_on_user_id", using: :btree
  end

  create_table "ledgers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "currency"
    t.integer  "savings_target"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_ledgers_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      default: "", null: false
    t.string   "name",       default: "", null: false
    t.string   "provider",   default: "", null: false
    t.string   "uid",        default: "", null: false
    t.string   "image",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "ledger_subscribers", "ledgers"
  add_foreign_key "ledger_subscribers", "users"
  add_foreign_key "ledgers", "users"
end
