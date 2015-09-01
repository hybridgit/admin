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

ActiveRecord::Schema.define(version: 20150901125953) do

  create_table "addresses", force: :cascade do |t|
    t.string   "city",         limit: 255
    t.string   "sub_city",     limit: 255
    t.string   "woreda",       limit: 255
    t.string   "kebele",       limit: 255
    t.string   "house_number", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "phone_number", limit: 255
    t.integer  "profile_id",   limit: 4
  end

  create_table "cab_requests", force: :cascade do |t|
    t.string   "location",            limit: 255
    t.float    "location_lat",        limit: 24
    t.float    "location_long",       limit: 24
    t.string   "current_cell_no",     limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "driver_id",           limit: 4
    t.integer  "current_dirver_id",   limit: 4
    t.string   "customer_cell_no",    limit: 255
    t.boolean  "broadcast"
    t.boolean  "status"
    t.string   "chosen_drivers_ids",  limit: 255
    t.text     "more_locations",      limit: 65535
    t.boolean  "ordered"
    t.boolean  "location_selected"
    t.integer  "offer_count",         limit: 4
    t.boolean  "broadcasted"
    t.boolean  "deleted"
    t.integer  "final_driver_id",     limit: 4
    t.boolean  "closed"
    t.integer  "more_location_count", limit: 4
  end

  create_table "car_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "contact_methods", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "driver_registration_requests", force: :cascade do |t|
    t.string   "cell_no",             limit: 255
    t.text     "location",            limit: 65535
    t.boolean  "active"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "more_location_count", limit: 4
    t.string   "searched_location",   limit: 255
    t.boolean  "deleted"
  end

  create_table "drivers", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "profile_id",    limit: 4
    t.string   "name",          limit: 255
    t.string   "cell_no",       limit: 255
    t.string   "location",      limit: 255
    t.string   "location_lat",  limit: 255
    t.string   "location_long", limit: 255
  end

  create_table "emergency_contacts", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.integer  "relationship_id", limit: 4
    t.string   "phone_number",    limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "profile_id",      limit: 4
  end

  create_table "locations", force: :cascade do |t|
    t.string   "location_name", limit: 255
    t.float    "latitude",      limit: 24
    t.float    "longitude",     limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "operation_hours", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "controller", limit: 255
    t.string   "action",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "driver_id",                         limit: 4
    t.integer  "address_id",                        limit: 4
    t.integer  "car_type_id",                       limit: 4
    t.integer  "contact_method_id",                 limit: 4
    t.integer  "operation_hour_id",                 limit: 4
    t.string   "first_name",                        limit: 255
    t.string   "last_name",                         limit: 255
    t.string   "middle_name",                       limit: 255
    t.string   "drivers_license_id",                limit: 255
    t.date     "date_of_birth"
    t.boolean  "is_active"
    t.string   "profile_image_file_name",           limit: 255
    t.string   "profile_image_content_type",        limit: 255
    t.integer  "profile_image_file_size",           limit: 4
    t.datetime "profile_image_updated_at"
    t.string   "drivers_license_copy_file_name",    limit: 255
    t.string   "drivers_license_copy_content_type", limit: 255
    t.integer  "drivers_license_copy_file_size",    limit: 4
    t.datetime "drivers_license_copy_updated_at"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "role_permissions", force: :cascade do |t|
    t.integer  "role_id",       limit: 4
    t.integer  "permission_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "send_sms", force: :cascade do |t|
    t.string  "momt",     limit: 255
    t.string  "sender",   limit: 255
    t.string  "receiver", limit: 255
    t.text    "msgdata",  limit: 65535
    t.integer "sms_type", limit: 4
    t.string  "smsc_id",  limit: 255
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",           limit: 255
    t.string   "email",              limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "salt",               limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
