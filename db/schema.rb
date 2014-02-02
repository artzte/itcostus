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

ActiveRecord::Schema.define(version: 20131116230632) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "system_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reporting_type"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "category_transactions", force: true do |t|
    t.integer "matcher_id"
    t.integer "category_id"
    t.integer "transaction_id"
  end

  add_index "category_transactions", ["category_id"], name: "index_category_transactions_on_category_id", using: :btree
  add_index "category_transactions", ["matcher_id"], name: "index_category_transactions_on_matcher_id", using: :btree
  add_index "category_transactions", ["transaction_id"], name: "index_category_transactions_on_transaction_id", using: :btree

  create_table "matchers", force: true do |t|
    t.string   "words"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "transaction_id"
  end

  create_table "transactions", force: true do |t|
    t.string   "transaction_id"
    t.string   "account"
    t.datetime "posted_at"
    t.string   "description"
    t.decimal  "amount",               precision: 8, scale: 2
    t.string   "transaction_type"
    t.integer  "category_override_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "note"
  end

  add_index "transactions", ["posted_at"], name: "index_transactions_on_posted_at", using: :btree

end
