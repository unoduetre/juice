# frozen_string_literal: true

# Create stock prices table
class CreateStockPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_prices do |t|
      t.references :stock_symbol, null: false, foreign_key: true
      t.datetime :timestamp, null: false
      t.decimal :open, precision: 15, scale: 4, null: false
      t.decimal :high, precision: 15, scale: 4, null: false
      t.decimal :low, precision: 15, scale: 4, null: false
      t.decimal :close, precision: 15, scale: 4, null: false
      t.integer :volume, null: false

      t.timestamps
    end
    add_index :stock_prices, :timestamp
    add_index :stock_prices, %i[stock_symbol_id timestamp], unique: true
  end
end
