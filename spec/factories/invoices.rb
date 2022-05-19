FactoryBot.define do
  factory :invoice do
    customer { Faker::Number.unique.within(range: 1..100000) }
    merchant { Faker::Number.unique.within(range: 1..100000) }
    status { Faker::Lorem.word }
  end
end
