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

ActiveRecord::Schema.define(version: 2018_10_19_095724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invoices", force: :cascade do |t|
    t.float "price"
    t.string "buyer_tax_number"
    t.string "buyer_name"
    t.string "buyer_address"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_invoices_on_job_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "load_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["load_id"], name: "index_jobs_on_load_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "loads", force: :cascade do |t|
    t.integer "weight"
    t.string "start_location"
    t.string "end_location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_loads_on_user_id"
  end

  create_table "packages", force: :cascade do |t|
    t.integer "amount"
    t.integer "type"
    t.bigint "load_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["load_id"], name: "index_packages_on_load_id"
  end

  create_table "user_vehicles", force: :cascade do |t|
    t.string "plate_number"
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_vehicles_on_user_id"
    t.index ["vehicle_id"], name: "index_user_vehicles_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.string "tax_number"
    t.string "address"
    t.bigint "load_id"
    t.bigint "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_users_on_job_id"
    t.index ["load_id"], name: "index_users_on_load_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
