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

ActiveRecord::Schema.define(version: 2020_02_11_140459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.integer "sekisui_div", limit: 2, default: 0, null: false
    t.string "sekisui_num", limit: 7, default: "", null: false
    t.integer "type_div", limit: 2, default: 0, null: false
    t.float "lat", default: 35.7012, null: false
    t.float "lon", default: 140.0906, null: false
    t.string "zip_cd", limit: 7, default: "", null: false
    t.string "address", limit: 200, default: "", null: false
    t.integer "floor"
    t.text "memo"
    t.bigint "ooya_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ooya_id"], name: "index_buildings_on_ooya_id"
  end

  create_table "ooyas", force: :cascade do |t|
    t.string "surname", limit: 20, null: false
    t.string "name", limit: 20, null: false
    t.string "surname_kana", limit: 40, null: false
    t.string "name_kana", limit: 40, null: false
    t.string "zip_cd", limit: 7, default: "", null: false
    t.string "address1", limit: 120, default: "", null: false
    t.string "address2", limit: 120, default: "", null: false
    t.string "tel", limit: 20, default: "", null: false
    t.string "mobile", limit: 20, default: "", null: false
    t.text "memo", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buildings", "ooyas"
end
