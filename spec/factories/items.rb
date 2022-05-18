FactoryBot.define do
  factory :item do
    name { Faker::String.random(length: 3..12) }
    description { Faker::Lorem.paragraph }
    unit_price { Faker::Number.decimal(r_digits: 2) }
    merchant { Faker::Number.unique.within(range: 1..100000) }
  end
end
