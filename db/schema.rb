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

ActiveRecord::Schema[7.2].define(version: 2024_10_12_201110) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_rates", force: :cascade do |t|
    t.date "date"
    t.float "usd"
    t.float "jpy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_exchange_rates_on_date", unique: true
  end

  create_table "rates", force: :cascade do |t|
    t.string "sailing_code"
    t.float "rate"
    t.string "rate_currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sailing_code"], name: "index_rates_on_sailing_code", unique: true
  end

  create_table "shipping_options", force: :cascade do |t|
    t.string "origin_port"
    t.string "destination_port"
    t.date "departure_date"
    t.date "arrival_date"
    t.string "sailing_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sailing_code"], name: "index_shipping_options_on_sailing_code", unique: true
  end
end
