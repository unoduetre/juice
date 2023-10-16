# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockPricesJob do
  describe '#perform' do
    it 'calls method for every stock symbol' do
      expect(StockSymbol).to receive(:find_each).once.with(no_args)
      subject.perform
    end
  end
end
