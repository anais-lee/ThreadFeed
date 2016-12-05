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
Shop.create!(name: "Anthropologie", 
            url: "www.anthropologie.com")
Shop.create!(name: "JCrew", 
            url: "www.jcrew.com")
Shop.create!(name: "Loft", 
            url: "www.loft.com")
Shop.create!(name: "Nasty Gal", 
            url: "www.nastygal.com")
Shop.create!(name: "Nordstrom", 
            url: "www.nordstrom.com")
Shop.create!(name: "Bloomingdales", 
            url: "www.bloomingdales.com")
Shop.create!(name: "Need Supply Co.", 
            url: "www.needsupply.com")
Shop.create!(name: "Urban Outfitters", 
            url: "www.uo.com")
Shop.create!(name: "Gap", 
            url: "www.gap.com")
Shop.create!(name: "Athleta", 
            url: "www.athleta.com")
Shop.create!(name: "American Eagle", 
            url: "www.ae.com")
Shop.create!(name: "Lululemon", 
            url: "www.lululemon.com")
Shop.create!(name: "Forever 21", 
            url: "www.forever21.com")
Shop.create!(name: "Tobi", 
            url: "www.tobi.com")
Shop.create!(name: "Francesca's", 
            url: "www.francescas.com")
Shop.create!(name: "Charlotte Russe", 
            url: "www.charlotterusse.com")
Shop.create!(name: "Zara", 
            url: "www.zara.com")
Shop.create!(name: "H&M", 
            url: "www.hm.com")
Shop.create!(name: "Wet Seal", 
            url: "www.wetseal.com")
Shop.create!(name: "ASOS", 
            url: "www.asos.com")
Shop.create!(name: "Revolve", 
            url: "www.revolve.com")
Shop.create!(name: "Reformation", 
            url: "www.thereformation.com")
Shop.create!(name: "Theory", 
            url: "www.theory.com")
Shop.create!(name: "Everlane", 
            url: "www.everlane.com")
Shop.create!(name: "Grana", 
            url: "www.grana.com")
Shop.create!(name: "Uniqlo", 
            url: "www.uniqlo.com")
Shop.create!(name: "American Apparel", 
            url: "www.americanapparel.com")
Shop.create!(name: "La Garconne", 
            url: "www.lagarconne.com")
Shop.create!(name: "COS", 
            url: "www.cosstores.com")
Shop.create!(name: "Aritzia", 
            url: "www.aritzia.com")
Shop.create!(name: "Net-A-Porter", 
            url: "www.net-a-porter.com")
Shop.create!(name: "Opening Ceremony", 
            url: "www.openingceremony.com")
Shop.create!(name: "Creatures of Comfort", 
            url: "www.creaturesofcomfort.com")
Shop.create!(name: "Oak", 
            url: "www.oaknyc.com")
Shop.create!(name: "ShopBop", 
            url: "www.shopbop.com")


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
following = shops[0...10]
followers = users[3..40]
following.each { |followed| user.follow(followed) } #first user follows all shops
followers.each { |follower| follower.follow(shop) } #all users follow first shop




