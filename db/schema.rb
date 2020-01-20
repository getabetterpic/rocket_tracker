# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_20_125501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "kits", force: :cascade do |t|
    t.bigint "manufacturer_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manufacturer_id"], name: "index_kits_on_manufacturer_id"
  end

  create_table "manufacturers", force: :cascade do |t|
    t.citext "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_manufacturers_on_name", unique: true
  end

  create_table "motors", force: :cascade do |t|
    t.bigint "manufacturer_id", null: false
    t.string "code"
    t.boolean "single_use"
    t.boolean "reloadable"
    t.integer "diameter"
    t.jsonb "specs"
    t.jsonb "thrust_curve"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["manufacturer_id"], name: "index_motors_on_manufacturer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.citext "email"
    t.string "sub", null: false
    t.string "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["resource_id"], name: "index_users_on_resource_id", unique: true
    t.index ["sub"], name: "index_users_on_sub", unique: true
  end

end
