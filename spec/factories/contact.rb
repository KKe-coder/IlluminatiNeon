FactoryBot.define do
  factory :contact do
    name { SecureRandom.alphanumeric(10) }
    email { Faker::Internet.email }
    message { SecureRandom.alphanumeric(200) }
  end
end