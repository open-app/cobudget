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

ActiveRecord::Schema.define(version: 201402270900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "budget_id"
  end

  create_table "buckets", force: true do |t|
    t.integer  "budget_id",                     null: false
    t.string   "name",                          null: false
    t.text     "description"
    t.text     "state"
    t.datetime "funded_at"
    t.datetime "cancelled_at"
    t.integer  "minimum_cents"
    t.integer  "maximum_cents"
    t.integer  "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",      default: false, null: false
  end

  create_table "budgets", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "bucket_id",  null: false
    t.integer  "user_id",    null: false
    t.text     "body"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["ancestry"], name: "index_comments_on_ancestry", using: :btree

  create_table "entries", force: true do |t|
    t.string   "description"
    t.integer  "identifier"
    t.integer  "account_id"
    t.integer  "transaction_id"
    t.integer  "amount_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_type"
  end

  create_table "transactions", force: true do |t|
    t.integer  "creator_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                               null: false
    t.string   "bg_color",        default: "#FFFFFF"
    t.string   "fg_color",        default: "#FFFFFF"
    t.string   "role"
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
