# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'

gem 'dotenv-rails', groups: %i[development test]

gem 'async-http-faraday', '~> 0.12.0'
gem 'attr_extras', '~> 7.1'
gem 'bcrypt', '~> 3.1'
gem 'bootsnap', require: false
gem 'cssbundling-rails', '~> 1.3'
gem 'faraday', '~> 2.7'
gem 'faraday-retry', '~> 2.2'
gem 'jbuilder', '~> 2.11'
gem 'jsbundling-rails', '~> 1.2'
gem 'multi_json', '~> 1.15'
gem 'oj', '~> 3.16'
gem 'puma', '~> 6.4'
gem 'rails', '~> 7.1.1'
gem 'sidekiq', '~> 7.1'
gem 'sidekiq-scheduler', '~> 5.0'
gem 'sprockets-rails', '~> 3.4'
gem 'sqlite3', '~> 1.6'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit', require: false
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.2'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-inline'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

group :development do
  gem 'memory_profiler'
  gem 'rack-mini-profiler', require: false
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'stackprof'
  gem 'web-console'
end

group :test do
  gem 'rspec-rails', '~> 6.0'
  gem 'shoulda-matchers', '~> 5.3'
  gem 'vcr', '~> 6.2'
  gem 'webmock', '~> 3.19'
end
