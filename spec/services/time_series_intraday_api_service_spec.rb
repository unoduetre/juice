# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeSeriesIntradayApiService do
  subject { described_class.new(symbol: 'IBM') }

  describe '#query' do
    let(:expected_query) do
      {
        apikey: a_kind_of(String),
        function: 'TIME_SERIES_INTRADAY',
        interval: '5min',
        symbol: 'IBM'
      }
    end

    it 'returns correct query' do
      expect(subject.query).to match(expected_query)
    end
  end
end
