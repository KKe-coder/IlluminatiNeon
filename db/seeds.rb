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
  name = Faker::Name.last_name
  email = Faker::Internet.email
  password = 'password'
  User.create!(
  name: name,
  email: email,
  residence: User.residences.keys.sample,
  password: password,
  password_confirmation: password,
 )
end

30.times do |n|
  Faker::Config.locale = :en
  title = Faker::Lorem.word
  impression = Faker::Lorem.sentence
  Post.create!(
  user: User.find(rand(1..20)),
  title: title,
  category: Post.categories.keys.sample,
  color: Post.colors.keys.sample,
  place: Post.places.keys.sample,
  impression: impression,
  rate: 3,
  avgrate: 3
  )
  Faker::Config.locale = :ja
end

30.times do |n|
  Faker::Config.locale = :en
  title = Faker::Lorem.sentence
  Post.create!(
  user: User.find(rand(1..20)),
  title: title
  )
  Faker::Config.locale = :ja
end