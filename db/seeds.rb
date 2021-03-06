# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: ENV['ADMIN_ID'],
                  password: ENV['ADMIN_PW'],
                  password_confirmation: ENV['ADMIN_PW'])

20.times do |n|
  name = Faker::Lorem.characters(number: 1..6)
  email = Faker::Internet.email
  password = 'password'
  User.create!(
  name: name,
  email: email,
  residence: User.residences.keys.sample,
  password: password,
  password_confirmation: password,
  profile_image: open("./db/profile_image/profile_image#{n}.jpg")
  )
end

10.times do |n|
  Faker::Config.locale = :en
  title = Faker::Lorem.characters(number: 1..7)
  impression = Faker::Lorem.characters(number: 1..100)
  Post.create!(
  user: User.find(rand(1..20)),
  title: title,
  category: "Illumination",
  color: Post.colors.keys.sample,
  place: Post.places.keys.sample,
  impression: impression,
  rate: 3,
  avgrate: 3,
  image: open("./db/post_image_ill/post_image_ill#{n}.jpg")
  )
  Faker::Config.locale = :ja
end

10.times do |n|
  Faker::Config.locale = :en
  title = Faker::Lorem.characters(number: 1..7)
  impression = Faker::Lorem.characters(number: 1..100)
  Post.create!(
  user: User.find(rand(1..20)),
  title: title,
  category: "Neon",
  color: Post.colors.keys.sample,
  place: Post.places.keys.sample,
  impression: impression,
  rate: 3,
  avgrate: 3,
  image: open("./db/post_image_neo/post_image_neo#{n}.jpg")
  )
  Faker::Config.locale = :ja
end

30.times do |n|
  Faker::Config.locale = :en
  body = Faker::Lorem.characters(number: 1..30)
  Murmur.create!(
  user: User.find(rand(1..20)),
  body: body
  )
  Faker::Config.locale = :ja
end