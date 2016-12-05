# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "Admin User",
             email: "admin@admin.com",
             password:              "admin123",
             password_confirmation: "admin123",
             admin: true)


Shop.create!(name:  "Madewell",
             url: "www.madewell.com")

99.times do |n|
  name  = Faker::Name.name
  url = "example-#{n+1}.shopper.com"
  Shop.create!(name:  name,
               url: url)
end

shops = Shop.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  shops.each { 
    |shop| shop.shop_posts.create!(content: content, 
      picture: "https://i.s-madewell.com/is/image/madewell/E4761_WP4596_m?$pdp_fs418$") }
end