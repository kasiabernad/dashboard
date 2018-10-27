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

ActiveRecord::Schema.define(version: 2018_10_27_144640) do

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
    t.integer "weight"
    t.integer "kind"
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
    t.string "firstname"
    t.string "surname"
    t.string "tax_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_view "light_loads", materialized: true,  sql_definition: <<-SQL
      WITH sum AS (
           SELECT loads.id,
              loads.start_date AS startdate,
              loads.start_location AS location,
              sum(packages.weight) AS total_weight
             FROM (loads
               JOIN packages ON ((loads.id = packages.load_id)))
            GROUP BY loads.start_location, loads.id, loads.start_date
          )
   SELECT sum.id,
      sum.startdate,
      sum.location,
      sum.total_weight
     FROM sum
    WHERE (sum.total_weight < 10000);
  SQL

  create_view "matched_loads", materialized: true,  sql_definition: <<-SQL
      SELECT DISTINCT l.id,
      sum(p.weight) AS total_weight
     FROM loads l,
      vehicles v,
      packages p
    WHERE (l.id = p.load_id)
    GROUP BY l.id, v.capacity
   HAVING (v.capacity > sum(p.weight));
  SQL

  create_view "load_creator_drivers", materialized: true,  sql_definition: <<-SQL
      SELECT (((creators.firstname)::text || ' '::text) || (creators.surname)::text) AS creator,
      ( SELECT (((drivers.firstname)::text || ' '::text) || (drivers.surname)::text) AS driver
             FROM users drivers
            WHERE ((jobs.load_id = loads.id) AND (loads.user_id = drivers.id))) AS driver,
      loads.id AS load,
      jobs.id AS job
     FROM ((users creators
       JOIN jobs ON ((creators.id = jobs.user_id)))
       JOIN loads ON ((jobs.load_id = loads.id)));
  SQL

  create_view "tax_numbers", materialized: true,  sql_definition: <<-SQL
      SELECT 'Buyer'::text AS kind,
      invoices.buyer_name AS name,
      invoices.buyer_tax_number AS tax_number
     FROM invoices
  UNION
   SELECT 'Seller'::text AS kind,
      (((users.firstname)::text || ' '::text) || (users.surname)::text) AS name,
      users.tax_number
     FROM users;
  SQL

  create_view "recursive_users", materialized: true,  sql_definition: <<-SQL
      WITH RECURSIVE creators(creator_id, creator_firstname, creator_surname, driver) AS (
           SELECT cr.id,
              cr.firstname,
              cr.surname,
              ( SELECT drs.id
                     FROM users drs
                    WHERE ((jobs.load_id = loads.id) AND (loads.user_id = drs.id))) AS driver_id
             FROM ((users cr
               JOIN jobs ON ((cr.id = jobs.user_id)))
               JOIN loads ON ((jobs.load_id = loads.id)))
          UNION
           SELECT creators_1.creator_id,
              creators_1.creator_firstname,
              creators_1.creator_surname,
              ( SELECT drs.id
                     FROM users drs
                    WHERE ((jobs.load_id = loads.id) AND (loads.user_id = drs.id))) AS driver_id
             FROM ((creators creators_1
               JOIN jobs ON ((creators_1.creator_id = jobs.user_id)))
               JOIN loads ON ((jobs.load_id = loads.id)))
          )
   SELECT (((creators.creator_firstname)::text || ' '::text) || (creators.creator_surname)::text) AS creator,
      (((drivers.firstname)::text || ' '::text) || (drivers.surname)::text) AS driver
     FROM (creators
       JOIN users drivers ON ((creators.driver = drivers.id)));
  SQL

end
