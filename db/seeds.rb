# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#make shop + other shops
Shop.create!(name:  "Madewell",
             url: "www.madewell.com")
Shop.create!(name: "TopShop", 
            url: "www.topshop.com")

70.times do |n|
  name  = Faker::Company.name
  url = "example-#{n+1}.shopper.com"
  Shop.create!(name:  name,
               url: url)
end


#make admin user + other users
User.create!(name:  "Admin User",
             email: "admin@admin.com",
             password:              "admin123",
             password_confirmation: "admin123",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

shops = Shop.order(:created_at).take(6)
60.times do
  content = Faker::Lorem.sentence(5)
  shops.each { 
    |shop| shop.shop_posts.create!(content: content) }
end



# Following relationships
users = User.all
shops = Shop.all
user = users.first #should be admin 
shop  = shops.first #should be madewell
following = shops[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) } #first user follows all shops
followers.each { |follower| follower.follow(shop) } #all users follow first shop




