# frozen_string_literal: true

# TIME_SERIES_INTRADAY Alpha Vantage request
class TimeSeriesIntradayApiService < AlphaVantageApiService
  vattr_initialize [:symbol!]

  def query
    super.merge({
      function: 'TIME_SERIES_INTRADAY',
      interval: '5min',
      symbol:
    })
  end
end
