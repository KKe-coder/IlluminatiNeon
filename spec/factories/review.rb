FactoryBot.define do
  factory :review do
    rate { 3 }
    comment { Faker::Lorem.characters(number:20) }
  end
end