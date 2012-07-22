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

ActiveRecord::Schema.define(:version => 20120722222827) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bodycomps", :force => true do |t|
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
    t.string   "sex",                 :default => "Female"
    t.float    "waist"
    t.float    "hip"
    t.float    "neck"
    t.float    "shoulder"
    t.float    "chest"
    t.float    "arm"
    t.float    "thigh"
    t.float    "gastroc"
    t.text     "notes"
    t.float    "bia_bodyfat"
    t.boolean  "is_bia"
    t.string   "circumference_units", :default => "inches"
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
    t.boolean  "ibs"
    t.text     "notes"
    t.integer  "trainer_id"
    t.integer  "document_id"
  end

  create_table "clients_documents", :id => false, :force => true do |t|
    t.integer "client_id"
    t.integer "document_id"
  end

  create_table "documents", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "file"
    t.integer  "trainer_id"
    t.integer  "client_id"
  end

  create_table "exercise_sessions", :force => true do |t|
    t.integer  "exercise_id"
    t.integer  "workout_session_id"
    t.string   "rest"
    t.string   "tempo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sets"
  end

  create_table "exercises", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "foodlogs", :force => true do |t|
    t.integer  "client_id"
    t.text     "log"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "details"
  end

  create_table "gyms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "images", :force => true do |t|
    t.integer  "album_id"
    t.binary   "image_file_data"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "credit_card_number"
    t.date     "credit_card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", :force => true do |t|
    t.string   "name"
    t.float    "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_token"
    t.string   "coupon"
  end

  create_table "trainers", :force => true do |t|
    t.integer  "gym_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "coach",                  :default => false
    t.integer  "group_id"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_client",              :default => false
    t.integer  "client_training_id"
    t.boolean  "has_free_subscription",  :default => false
    t.string   "logo_image"
    t.boolean  "is_trainer"
    t.boolean  "is_gym"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "auth_token"
  end

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.text     "embed_code"
    t.integer  "owner_id"
    t.integer  "client_id"
    t.string   "url",        :null => false
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weight_sets", :force => true do |t|
    t.float    "weight"
    t.integer  "reps"
    t.integer  "exercise_session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "duration"
  end

  create_table "workout_sessions", :force => true do |t|
    t.integer  "workout_id"
    t.integer  "user_id"
    t.text     "notes"
    t.datetime "date"
    t.string   "supplements"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.boolean  "reminder_sent", :default => false
  end

  create_table "workouts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

end
