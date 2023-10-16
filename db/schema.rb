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

ActiveRecord::Schema[7.1].define(version: 2023_10_15_190544) do
  create_table "stock_prices", force: :cascade do |t|
    t.integer "stock_symbol_id", null: false
    t.datetime "timestamp", null: false
    t.decimal "open", precision: 15, scale: 4, null: false
    t.decimal "high", precision: 15, scale: 4, null: false
    t.decimal "low", precision: 15, scale: 4, null: false
    t.decimal "close", precision: 15, scale: 4, null: false
    t.integer "volume", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_symbol_id", "timestamp"], name: "index_stock_prices_on_stock_symbol_id_and_timestamp", unique: true
    t.index ["stock_symbol_id"], name: "index_stock_prices_on_stock_symbol_id"
    t.index ["timestamp"], name: "index_stock_prices_on_timestamp"
  end

  create_table "stock_symbols", force: :cascade do |t|
    t.string "symbol", null: false
    t.string "time_zone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["symbol"], name: "index_stock_symbols_on_symbol", unique: true
  end

  add_foreign_key "stock_prices", "stock_symbols"
end
