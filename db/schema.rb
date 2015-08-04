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

ActiveRecord::Schema.define(version: 20150804084947) do

  create_table "cab_requests", force: :cascade do |t|
    t.string   "location",        limit: 255
    t.float    "location_lat",    limit: 24
    t.float    "location_long",   limit: 24
    t.string   "current_cell_no", limit: 255
    t.integer  "driver_list_id",  limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "cab_requests", ["driver_list_id"], name: "index_cab_requests_on_driver_list_id", using: :btree

  create_table "driver_lists", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.float    "location_lat",  limit: 24
    t.float    "location_long", limit: 24
    t.string   "location",      limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "driver_registration_requests", force: :cascade do |t|
    t.string   "cell_no",    limit: 255
    t.text     "location",   limit: 65535
    t.boolean  "active"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.float    "location_lat",  limit: 24
    t.float    "location_long", limit: 24
    t.string   "location",      limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "location_name", limit: 255
    t.float    "latitude",      limit: 24
    t.float    "longitude",     limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "cab_requests", "driver_lists"
end
