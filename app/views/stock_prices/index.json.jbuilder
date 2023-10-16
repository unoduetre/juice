# frozen_string_literal: true

json.partial! 'shared/status_success'
json.body @stock_prices, partial: 'stock_price', as: 'stock_price'
