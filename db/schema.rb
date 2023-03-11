# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_04_160317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camps", force: :cascade do |t|
    t.string "place", null: false
    t.date "startdate", null: false
    t.date "enddate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "email", null: false
    t.date "dob", null: false
    t.string "street", null: false
    t.string "zip", null: false
    t.string "city", null: false
    t.string "country_code", null: false
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.date "arrival_date"
    t.date "departure_date"
    t.bigint "camp_id", null: false
    t.bigint "room_id"
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_registrations_on_camp_id"
    t.index ["person_id"], name: "index_registrations_on_person_id"
    t.index ["room_id"], name: "index_registrations_on_room_id"
  end

  create_table "responsibilities", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "registration_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_responsibilities_on_person_id"
    t.index ["registration_id"], name: "index_responsibilities_on_registration_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "number", null: false
    t.string "floor", null: false
    t.integer "capacity", null: false
    t.bigint "camp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_rooms_on_camp_id"
  end

  add_foreign_key "registrations", "camps"
  add_foreign_key "registrations", "people"
  add_foreign_key "registrations", "rooms"
  add_foreign_key "responsibilities", "people"
  add_foreign_key "responsibilities", "registrations"
  add_foreign_key "rooms", "camps"
end
