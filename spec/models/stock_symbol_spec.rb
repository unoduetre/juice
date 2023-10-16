# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StockSymbol do
  describe 'columns' do
    it { is_expected.to have_db_column(:symbol).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:time_zone).of_type(:string).with_options(null: true) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:symbol).unique }
  end

  describe 'associations' do
    it { is_expected.to have_many(:stock_prices).inverse_of(:stock_symbol).dependent(:destroy) }
  end

  describe 'validations' do
    subject { create(:stock_symbol) }

    it { is_expected.to validate_presence_of(:symbol) }
    it { is_expected.to validate_presence_of(:time_zone).allow_nil }
    it { is_expected.to validate_uniqueness_of(:symbol) }
  end

  describe '#update_stock_prices' do
    subject { create(:stock_symbol, symbol: 'IBM', time_zone:) }

    let(:stock_price) { create(:stock_price, stock_symbol: subject, timestamp: 100.years.ago) }

    context 'with empty time zone' do
      let(:time_zone) { nil }

      it 'updates stock prices' do
        VCR.use_cassette('update_stock_prices') do
          expect { subject.update_stock_prices }.to change(StockPrice, :count).from(0).to(100)
        end
      end

      it 'updates time zone' do
        VCR.use_cassette('update_stock_prices') do
          expect { subject.update_stock_prices }.to change(subject, :time_zone).from(nil).to('US/Eastern')
        end
      end
    end

    context 'with same time zone' do
      let(:time_zone) { 'US/Eastern' }

      it 'updates stock prices' do
        VCR.use_cassette('update_stock_prices') do
          stock_price
          expect { subject.update_stock_prices }.to change(StockPrice, :count).from(1).to(101)
        end
      end

      it 'updates time zone' do
        VCR.use_cassette('update_stock_prices') do
          expect { subject.update_stock_prices }.not_to change(subject, :time_zone)
        end
      end
    end

    context 'with different time zone' do
      let(:time_zone) { 'Europe/London' }

      it 'updates stock prices' do
        VCR.use_cassette('update_stock_prices') do
          stock_price
          expect { subject.update_stock_prices }.to change(StockPrice, :count).from(1).to(100)
        end
      end

      it 'updates time zone' do
        VCR.use_cassette('update_stock_prices') do
          expect { subject.update_stock_prices }.to change(subject, :time_zone).from('Europe/London').to('US/Eastern')
        end
      end
    end
  end
end
