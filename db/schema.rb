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

ActiveRecord::Schema.define(version: 20150505220955) do

  create_table "appointments", force: true do |t|
    t.integer  "user_id"
    t.integer  "time_slot_id"
    t.boolean  "is_checkedin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "class_slot_id"
    t.integer  "buddy_slot_id"
  end

  add_index "appointments", ["buddy_slot_id"], name: "index_appointments_on_buddy_slot_id"

  create_table "articles", force: true do |t|
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buddy_slots", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "buddy_walk_id"
    t.datetime "start_time"
    t.datetime "end_time"
  end

  add_index "buddy_slots", ["buddy_walk_id"], name: "index_buddy_slots_on_buddy_walk_id"

  create_table "buddy_walks", force: true do |t|
    t.string   "title"
    t.string   "place"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "class_slots", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "total_capacity"
    t.integer  "remaining_capacity"
    t.integer  "ds_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "days", force: true do |t|
    t.string   "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "class_slot_id"
  end

  add_index "days", ["class_slot_id"], name: "index_days_on_class_slot_id"

  create_table "ds_classes", force: true do |t|
    t.string   "title"
    t.string   "place"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "place"
    t.text     "description"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "total_capacity"
    t.integer  "remaining_capacity"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "address"
    t.string   "phone"
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_phone"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.string   "reset_digest"
    t.datetime "activated_at"
    t.datetime "reset_sent_at"
    t.boolean  "activated",                   default: false
    t.boolean  "admin",                       default: false
    t.datetime "event_register_email_notify"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "staff",                       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
