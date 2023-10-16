# frozen_string_literal: true

# Stock price for particular stock symbol at particular time
class StockPrice < ApplicationRecord
  belongs_to :stock_symbol, inverse_of: :stock_prices

  validates :timestamp, presence: true, uniqueness: { scope: :stock_symbol_id }
  validates :open, presence: true
  validates :high, presence: true
  validates :low, presence: true
  validates :close, presence: true
  validates :volume, presence: true
end
