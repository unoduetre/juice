# frozen_string_literal: true

# Stock symbol
class StockSymbol < ApplicationRecord
  has_many :stock_prices, inverse_of: :stock_symbol, dependent: :destroy

  validates :symbol, presence: true, uniqueness: true
  validates :time_zone, presence: true, allow_nil: true

  PRICES_DIG_KEY = [:'Time Series (5min)'].freeze
  TIME_ZONE_DIG_KEY = [:'Meta Data', :'6. Time Zone'].freeze

  def update_stock_prices
    prices, retrieved_time_zone = retrieve_and_parse_response
    stock_prices.delete_all if time_zone != retrieved_time_zone
    initialize_and_save_time_zone(retrieved_time_zone)
    save_stock_prices(prices)
  end

  private

  def retrieve_and_parse_response
    response = TimeSeriesIntradayApiService.new(symbol:).call
    prices = response.dig(*PRICES_DIG_KEY)
    retrieved_time_zone = response.dig(*TIME_ZONE_DIG_KEY)
    [prices, retrieved_time_zone]
  end

  def initialize_and_save_time_zone(retrieved_time_zone)
    return unless time_zone.nil? || time_zone != retrieved_time_zone

    self.time_zone = retrieved_time_zone
    save!
  end

  def timestamps(prices)
    prices.keys.map do |timestamp_text|
      [timestamp_text, Time.find_zone!(time_zone).parse(timestamp_text.to_s)]
    end
  end

  def filtered_timestamps(prices, newest_timestamp)
    timestamps(prices).select do |(_, timestamp)|
      timestamp > newest_timestamp
    end
  end

  def processed_timestamps(prices)
    newest_timestamp = stock_prices.order(timestamp: :desc).first&.timestamp
    if newest_timestamp.nil?
      timestamps(prices)
    else
      filtered_timestamps(prices, newest_timestamp)
    end
  end

  def save_stock_price(timestamp, price)
    stock_prices.create!(
      timestamp:,
      open: price[:'1. open'],
      high: price[:'2. high'],
      low: price[:'3. low'],
      close: price[:'4. close'],
      volume: price[:'5. volume']
    )
  end

  def save_stock_prices(prices)
    transaction do
      processed_timestamps(prices).each do |(timestamp_text, timestamp)|
        price = prices[timestamp_text]
        save_stock_price(timestamp, price)
      end
    end
  end
end
