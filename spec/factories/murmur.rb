FactoryBot.define do
  factory :murmur do
    body { Faker::Lorem.characters(number:30) }
  end
end