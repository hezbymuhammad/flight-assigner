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

ActiveRecord::Schema.define(version: 2019_09_15_032626) do

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "seat_id"
    t.integer "plane_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plane_id"], name: "index_orders_on_plane_id"
    t.index ["seat_id"], name: "index_orders_on_seat_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "planes", force: :cascade do |t|
    t.string "dimension"
    t.string "name"
    t.boolean "prototype_only", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.integer "plane_id"
    t.integer "section_idx"
    t.integer "column_idx"
    t.integer "row_idx"
    t.integer "queue_number", default: 0, null: false
    t.boolean "occupied", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plane_id"], name: "index_seats_on_plane_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
