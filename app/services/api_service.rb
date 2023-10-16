# frozen_string_literal: true

# Base class for an external API endpoint
class ApiService
  # Error raised when API call unsuccessful
  class ApiServiceCallError < StandardError
    def initialize(message = 'ERROR: API Service call resulted in an error', ...)
      super(message, ...)
    end
  end

  attr_implement :host

  def method
    :get
  end

  def headers
    {}
  end

  def body
    nil
  end

  def protocol
    'https'
  end

  def port; end

  def query
    {}
  end

  def path; end

  def url
    prefixed_port = port.to_s
    prefixed_port = ":#{prefixed_port}" if prefixed_port.present?
    "#{protocol}://#{host}#{prefixed_port}#{path}?#{query.to_query}"
  end

  def call
    raw_response = connection.run_request(method, url, body, headers)
    check_raw_response(raw_response)
    response = MultiJson.load(raw_response.body, symbolize_keys: true)
    check_response(response)
    response
  rescue StandardError
    raise ApiServiceCallError
  end

  protected

  def retry_options
    {
      methods: %i[get],
      max: 2,
      interval: 0.05,
      interval_randomness: 0.5,
      backoff_factor: 2
    }
  end

  def connection
    Faraday.new do |faraday|
      faraday.request :retry, retry_options
      faraday.response(:logger, Rails.logger) do |logger|
        logger.filter(/(apikey=)[^&]+/, '\1REMOVED')
      end
    end
  end

  def check_raw_response(raw_response)
    raise "ERROR: Response not successful (#{raw_response.status})" unless raw_response.success?
    raise 'ERROR: Empty response body received' if raw_response.body.blank?
  end

  def check_response(response)
    raise 'ERROR: Empty JSON received' if response.blank?
  end
end
