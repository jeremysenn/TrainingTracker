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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110410180909) do

  create_table "biosignatures", :force => true do |t|
    t.date     "date"
    t.integer  "client_id"
    t.integer  "age"
    t.integer  "height"
    t.string   "height_units"
    t.integer  "weight"
    t.string   "weight_units"
    t.float    "chin"
    t.float    "cheek"
    t.float    "pec"
    t.float    "tri"
    t.float    "subscap"
    t.float    "suprailiac"
    t.float    "midaxil"
    t.float    "umbilical"
    t.float    "knee"
    t.float    "calf"
    t.float    "quad"
    t.float    "ham"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.string   "address"
    t.string   "country"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercise_sessions", :force => true do |t|
    t.integer  "exercise_id"
    t.integer  "workout_session_id"
    t.string   "rest"
    t.string   "tempo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "coach",         :default => false
  end

  create_table "weight_sets", :force => true do |t|
    t.float    "weight"
    t.integer  "reps"
    t.integer  "exercise_session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workout_sessions", :force => true do |t|
    t.integer  "workout_id"
    t.integer  "user_id"
    t.text     "notes"
    t.date     "date"
    t.string   "supplements"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

end
