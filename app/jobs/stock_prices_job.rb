# frozen_string_literal: true

# Stock prices job
class StockPricesJob < ApplicationJob
  discard_on Exception
  queue_as :default

  def perform
    StockSymbol.find_each do |stock_symbol|
      stock_symbol.update_stock_prices
    rescue StandardError => e
      logger.error("#{e.message}\n#{e.backtrace.join("\n")}")
    end
  end
end
