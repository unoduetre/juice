# frozen_string_literal: true

require 'async/http/faraday'
Faraday.default_adapter = :async_http
