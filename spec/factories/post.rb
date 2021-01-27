FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:7) }
    color { "Red" }
    category { "Illumination" }
    image {  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/profile.png'), 'image/png') }
    rate { 3 }
    place { "北海道" }
    impression { Faker::Lorem.characters(number:100) }
    avgrate { 3 }
  end
end