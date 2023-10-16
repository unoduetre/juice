# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlphaVantageApiService do
  describe 'API_KEY' do
    subject(:api_key) { described_class::API_KEY }

    it 'is loaded from environment' do
      expect(api_key).to be_present
    end
  end

  describe '#host' do
    it 'returns correct host' do
      expect(subject.host).to eq 'www.alphavantage.co'
    end
  end

  describe '#path' do
    it 'returns correct path' do
      expect(subject.path).to eq '/query'
    end
  end

  describe '#query' do
    it 'returns correct query' do
      expect(subject.query).to match({
        apikey: a_kind_of(String)
      })
    end
  end
end
