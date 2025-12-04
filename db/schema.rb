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

ActiveRecord::Schema[8.1].define(version: 2025_12_03_160340) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "created_by"
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
    t.string "updated_by"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.string "created_by"
    t.string "description"
    t.string "name"
    t.decimal "price"
    t.string "status"
    t.datetime "updated_at", null: false
    t.string "updated_by"
    t.index ["category_id"], name: "index_menus_on_category_id"
  end

  create_table "options", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "created_by"
    t.string "description"
    t.integer "menu_id", null: false
    t.string "name"
    t.decimal "price"
    t.string "status"
    t.datetime "updated_at", null: false
    t.string "updated_by"
    t.index ["menu_id"], name: "index_options_on_menu_id"
  end

  add_foreign_key "menus", "categories"
  add_foreign_key "options", "menus"
end
