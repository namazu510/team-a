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

ActiveRecord::Schema.define(version: 20160824062153) do
ActiveRecord::Schema.define(version: 20160823024204) do

  create_table "exercise_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start_time",  null: false
    t.datetime "end_time",    null: false
    t.integer  "step_cnt",    null: false
    t.float    "calorie",     null: false
    t.integer  "schedule_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["schedule_id"], name: "index_exercise_logs_on_schedule_id"
    t.index ["user_id"], name: "index_exercise_logs_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start_time", null: false
    t.datetime "end_time",   null: false
    t.string   "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "email"
    t.boolean  "admin",           null: false
    t.string   "password"
    t.integer  "gender"
    t.float    "height"
    t.integer  "age"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "weights", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "weight",     null: false
    t.float    "bmi",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weights_on_user_id"
  end

end
