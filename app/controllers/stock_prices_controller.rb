# frozen_string_literal: true

# Stock prices controller
class StockPricesController < ApplicationController
  def index
    @stock_prices = StockPrice.order(timestamp: :asc)
                              .where(stock_symbol_id: params[:stock_symbol_id], volume: params[:min_volume]..)
  rescue StandardError
    render_json_error(t('index_error'))
  end
end
