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

ActiveRecord::Schema[8.0].define(version: 2025_12_06_131853) do
  create_table "camp_team_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "camp_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_camp_team_members_on_camp_id"
    t.index ["user_id", "camp_id"], name: "index_camp_team_members_on_user_id_and_camp_id", unique: true
    t.index ["user_id"], name: "index_camp_team_members_on_user_id"
  end

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
    t.string "recipient"
    t.index ["street", "number", "zip_code", "town", "country_code", "recipient"], name: "index_households_on_address_and_recipient", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "first_name"
    t.string "phone"
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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.bigint "person_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["person_id"], name: "index_users_on_person_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "camp_team_members", "camps"
  add_foreign_key "camp_team_members", "users"
  add_foreign_key "camps", "places"
  add_foreign_key "people", "households"
  add_foreign_key "registrations", "camps"
  add_foreign_key "registrations", "people"
  add_foreign_key "room_assignments", "camps"
  add_foreign_key "room_assignments", "people"
  add_foreign_key "room_assignments", "rooms"
  add_foreign_key "rooms", "places"
  add_foreign_key "users", "people"
end
