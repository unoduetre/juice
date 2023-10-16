# frozen_string_literal: true

json.partial! 'shared/status_success'
json.body @stock_symbols, partial: 'stock_symbol', as: 'stock_symbol'
