# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/stock_symbols' do
  describe 'GET #index' do
    before do
      create(:stock_symbol)
    end

    it 'renders a successful response' do
      get stock_symbols_path(format: :json)
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new StockSymbol' do
        expect do
          post stock_symbols_path, params: { stock_symbol: { symbol: 'IBM' } }
        end.to change(StockSymbol, :count).by(1)
      end

      it 'returns JSON successfully' do
        post stock_symbols_path, params: { stock_symbol: { symbol: 'IBM' } }
        expect(MultiJson.load(response.body, symbolize_keys: true)).to eq({ status: 'success' })
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new StockSymbol' do
        expect do
          post stock_symbols_path, params: { stock_symbol: { symbol: '' } }
        end.not_to change(StockSymbol, :count)
      end

      it 'returns JSON erroeously' do
        post stock_symbols_path, params: { stock_symbol: { symbol: '' } }
        expect(MultiJson.load(response.body,
                              symbolize_keys: true)).to eq({ status: 'error', message: 'Record cannot be created' })
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with existing stock symbol' do
      let!(:stock_symbol) { create(:stock_symbol) }

      it 'destroys the requested stock_symbol' do
        expect do
          delete stock_symbol_path(stock_symbol)
        end.to change(StockSymbol, :count).by(-1)
      end

      it 'returns JSON successfully' do
        delete stock_symbol_path(stock_symbol)
        expect(MultiJson.load(response.body, symbolize_keys: true)).to eq({ status: 'success' })
      end
    end

    context 'with nonexisting stock symbol' do
      it 'returns JSON erroeously' do
        delete stock_symbol_path(123_456_789)
        expect(MultiJson.load(response.body,
                              symbolize_keys: true)).to eq({ status: 'error', message: 'Record cannot be destroyed' })
      end
    end
  end
end
