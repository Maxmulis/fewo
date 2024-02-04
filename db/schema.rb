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

ActiveRecord::Schema[7.1].define(version: 2023_10_22_031239) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "camps", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "place_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_camps_on_place_id"
  end

  create_table "households", force: :cascade do |t|
    t.string "street"
    t.string "zip_code"
    t.string "number"
    t.string "country_code"
    t.string "town"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "first_name"
    t.date "dob"
    t.bigint "household_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["household_id"], name: "index_people_on_household_id"
    t.index ["name", "first_name", "dob"], name: "index_people_on_name_and_first_name_and_dob", unique: true
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_places_on_name", unique: true
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "camp_id", null: false
    t.date "arrival_date"
    t.date "departure_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_registrations_on_camp_id"
    t.index ["person_id", "camp_id"], name: "index_registrations_on_person_id_and_camp_id", unique: true
    t.index ["person_id"], name: "index_registrations_on_person_id"
  end

  create_table "room_assignments", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "camp_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_room_assignments_on_camp_id"
    t.index ["person_id"], name: "index_room_assignments_on_person_id"
    t.index ["room_id"], name: "index_room_assignments_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "place_id", null: false
    t.integer "floor"
    t.integer "capacity"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_rooms_on_place_id"
  end

  add_foreign_key "camps", "places"
  add_foreign_key "people", "households"
  add_foreign_key "registrations", "camps"
  add_foreign_key "registrations", "people"
  add_foreign_key "room_assignments", "camps"
  add_foreign_key "room_assignments", "people"
  add_foreign_key "room_assignments", "rooms"
  add_foreign_key "rooms", "places"
end
