# frozen_string_literal: true

FactoryBot.define do
  factory :stock_price do
    stock_symbol
    sequence(:timestamp) { |n| Faker::Time.between(from: (n + 1).days.ago, to: n.days.ago) }
    open { Faker::Number.decimal(l_digits: 3, r_digits: 4) }
    high { Faker::Number.decimal(l_digits: 3, r_digits: 4) }
    low { Faker::Number.decimal(l_digits: 3, r_digits: 4) }
    close { Faker::Number.decimal(l_digits: 3, r_digits: 4) }
    volume { Faker::Number.number(digits: 2) }
  end
end
