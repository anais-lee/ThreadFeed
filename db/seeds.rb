# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#make shop + other shops
Shop.create!(name:  "Madewell",
             url: "http://www.madewell.com")
Shop.create!(name: "TopShop", 
            url: "http://www.topshop.com")
Shop.create!(name: "Anthropologie", 
            url: "http://www.anthropologie.com")
Shop.create!(name: "JCrew", 
            url: "http://www.jcrew.com")
Shop.create!(name: "Loft", 
            url: "http://www.loft.com")
Shop.create!(name: "Nasty Gal", 
            url: "http://www.nastygal.com")
Shop.create!(name: "Nordstrom", 
            url: "http://www.nordstrom.com")
Shop.create!(name: "Bloomingdales", 
            url: "http://www.bloomingdales.com")
Shop.create!(name: "Need Supply Co.", 
            url: "http://www.needsupply.com")
Shop.create!(name: "Urban Outfitters", 
            url: "http://www.uo.com")
Shop.create!(name: "Gap", 
            url: "http://www.gap.com")
Shop.create!(name: "Athleta", 
            url: "http://www.athleta.com")
Shop.create!(name: "American Eagle", 
            url: "http://www.ae.com")
Shop.create!(name: "Lululemon", 
            url: "http://www.lululemon.com")
Shop.create!(name: "Forever 21", 
            url: "http://www.forever21.com")
Shop.create!(name: "Tobi", 
            url: "http://www.tobi.com")
Shop.create!(name: "Francesca's", 
            url: "http://www.francescas.com")
Shop.create!(name: "Charlotte Russe", 
            url: "http://www.charlotterusse.com")
Shop.create!(name: "Zara", 
            url: "http://www.zara.com")
Shop.create!(name: "H&M", 
            url: "http://www.hm.com")
Shop.create!(name: "Wet Seal", 
            url: "http://www.wetseal.com")
Shop.create!(name: "ASOS", 
            url: "http://www.asos.com")
Shop.create!(name: "Revolve", 
            url: "http://www.revolve.com")
Shop.create!(name: "Reformation", 
            url: "http://www.thereformation.com")
Shop.create!(name: "Theory", 
            url: "http://www.theory.com")
Shop.create!(name: "Everlane", 
            url: "http://www.everlane.com")
Shop.create!(name: "Grana", 
            url: "http://www.grana.com")
Shop.create!(name: "Uniqlo", 
            url: "http://www.uniqlo.com")
Shop.create!(name: "American Apparel", 
            url: "http://www.americanapparel.com")
Shop.create!(name: "La Garconne", 
            url: "http://www.lagarconne.com")
Shop.create!(name: "COS", 
            url: "http://www.cosstores.com")
Shop.create!(name: "Aritzia", 
            url: "http://www.aritzia.com")
Shop.create!(name: "Net-A-Porter", 
            url: "http://www.net-a-porter.com")
Shop.create!(name: "Opening Ceremony", 
            url: "http://www.openingceremony.com")
Shop.create!(name: "Creatures of Comfort", 
            url: "http://www.creaturesofcomfort.com")
Shop.create!(name: "Oak", 
            url: "http://www.oaknyc.com")
Shop.create!(name: "ShopBop", 
            url: "http://www.shopbop.com")


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

shops = Shop.order(:created_at).take(6) #add 60 posts to first 6 shops
60.times do
  content = Faker::Lorem.sentence(5)
  shops.each { 
    |shop| shop.shop_posts.create!(content: content) 
  }
end

shops = Shop.all #add 5 posts to each shop
5.times do
  content = Faker::Lorem.sentence(5)
  shops.each {
    |shop| shop.shop_posts.create!(content: content) 
  }
end

shop_posts = ShopPost.order(:created_at).take(360)
3.times do
  name = Faker::Name.name
  price = "$58.00"
  main_img_url = Faker::Placeholdit.image
  shop_posts.each { |shop_post| shop_post.items.create!(name: name, 
    price: price, main_img_url:main_img_url) }
end

# Following relationships
users = User.all
shops = Shop.all
user = users.first #should be admin 
shop  = shops.first #should be madewell
following = shops[0...10]
followers = users[3..40]
following.each { |followed| user.follow(followed) } #first user follows all shops
followers.each { |follower| follower.follow(shop) } #all users follow first shop




