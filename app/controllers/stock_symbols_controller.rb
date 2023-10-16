# frozen_string_literal: true

# Stock symbols controller
class StockSymbolsController < ApplicationController
  def index
    @stock_symbols = StockSymbol.order(symbol: :asc)
  rescue StandardError
    render_json_error(t('index_error'))
  end

  def create
    StockSymbol.create!(stock_symbol_params)
    render_json_success
  rescue StandardError
    render_json_error(t('create_error'))
  end

  def destroy
    StockSymbol.find(params[:id]).destroy!
    render_json_success
  rescue StandardError
    render_json_error(t('destroy_error'))
  end

  private

  def stock_symbol_params
    params.require(:stock_symbol).permit(:symbol)
  end
end
