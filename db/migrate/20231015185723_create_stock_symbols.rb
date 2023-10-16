# frozen_string_literal: true

# Create stock symbols table
class CreateStockSymbols < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_symbols do |t|
      t.string :symbol, null: false
      t.string :time_zone, null: true

      t.timestamps
    end
    add_index :stock_symbols, :symbol, unique: true
  end
end
