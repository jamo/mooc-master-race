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

ActiveRecord::Schema.define(version: 20160411061228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: true do |t|
    t.string   "name"
    t.string   "nick"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "week1",                   precision: 5, scale: 2
    t.decimal  "week2",                   precision: 5, scale: 2
    t.decimal  "week3",                   precision: 5, scale: 2
    t.decimal  "week4",                   precision: 5, scale: 2
    t.decimal  "week5",                   precision: 5, scale: 2
    t.decimal  "week6",                   precision: 5, scale: 2
    t.decimal  "week7",                   precision: 5, scale: 2
    t.decimal  "week8",                   precision: 5, scale: 2
    t.decimal  "week9",                   precision: 5, scale: 2
    t.decimal  "week10",                  precision: 5, scale: 0
    t.decimal  "week11",                  precision: 5, scale: 0
    t.decimal  "week12",                  precision: 5, scale: 0
    t.string   "missing_points",                                  default: ""
    t.string   "key"
    t.integer  "interview_id"
    t.text     "essay"
    t.boolean  "message_sent",                                    default: false
    t.boolean  "ready_for_interview",                             default: false
    t.string   "original_missing_points"
    t.boolean  "arrived"
    t.datetime "arrival_time"
    t.decimal  "week13",                  precision: 5, scale: 0
    t.decimal  "week14",                  precision: 5, scale: 0
    t.text     "explanations",                                    default: [],    array: true
    t.decimal  "only_tmc_week1",          precision: 5, scale: 0
    t.decimal  "only_tmc_week2",          precision: 5, scale: 0
    t.decimal  "only_tmc_week3",          precision: 5, scale: 0
    t.decimal  "only_tmc_week4",          precision: 5, scale: 0
    t.decimal  "only_tmc_week5",          precision: 5, scale: 0
    t.decimal  "only_tmc_week6",          precision: 5, scale: 0
    t.decimal  "only_tmc_week7",          precision: 5, scale: 0
    t.decimal  "only_tmc_week8",          precision: 5, scale: 0
    t.decimal  "only_tmc_week9",          precision: 5, scale: 0
    t.decimal  "only_tmc_week10",         precision: 5, scale: 0
    t.decimal  "only_tmc_week11",         precision: 5, scale: 0
    t.decimal  "only_tmc_week12",         precision: 5, scale: 0
    t.decimal  "only_tmc_week13",         precision: 5, scale: 0
    t.decimal  "only_tmc_week14",         precision: 5, scale: 0
    t.text     "points_week1"
    t.text     "points_week2"
    t.text     "points_week3"
    t.text     "points_week4"
    t.text     "points_week5"
    t.text     "points_week6"
    t.text     "points_week7"
    t.text     "points_week8"
    t.text     "points_week9"
    t.text     "points_week10"
    t.text     "points_week11"
    t.text     "points_week12"
    t.text     "points_week13"
    t.text     "points_week14"
    t.string   "phone_number"
  end

  add_index "applicants", ["interview_id"], name: "index_applicants_on_interview_id", using: :btree

  create_table "interview_days", force: true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interviews", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "interview_day_id"
    t.datetime "start_time"
    t.integer  "duration_in_minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",              default: 0
  end

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "apprentice",      default: false
  end

end
