# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/stock_symbol/:stock_symbol_id/stock_prices' do
  describe 'GET #index' do
    let!(:stock_price) { create(:stock_price) }

    it 'renders a successful response' do
      get stock_symbol_stock_prices_path(stock_price.stock_symbol, format: :json)
      expect(response).to be_successful
    end
  end
end
