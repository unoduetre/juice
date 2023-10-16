# frozen_string_literal: true

# The base class for Alpha Vantage API endpoints
class AlphaVantageApiService < ApiService
  API_KEY = ENV.fetch('ALPHA_VANTAGE_API_KEY')

  def host
    'www.alphavantage.co'
  end

  def path
    '/query'
  end

  def query
    super.merge({
      apikey: API_KEY
    })
  end
end
