FactoryBot.define do
  factory :invoice_item do
    item { Faker::Number.unique.within(range: 1..100000) }
    invoice { Faker::Number.unique.within(range: 1..100000) }
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Number.decimal(r_digits: 2) }
  end
end