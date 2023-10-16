# frozen_string_literal: true

FactoryBot.define do
  factory :stock_symbol do
    sequence(:symbol) { |n| Faker::Alphanumeric.alpha(number: 3) + n.to_s }
    time_zone { Faker::Address.time_zone }
  end
end
