FactoryBot.define do
  factory :user do
    name { SecureRandom.alphanumeric(6) }
    email { Faker::Internet.email }
    residence {"東京都"}
    profile_image {  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/profile.png'), 'image/png') }
    password { SecureRandom.alphanumeric(6) }
    password_confirmation {password}
  end
end