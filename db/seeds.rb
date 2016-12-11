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
Shop.create!(name: "Athleta", 
            url: "http://www.athleta.com")
Shop.create!(name: "Nordstrom", 
            url: "http://www.nordstrom.com")
Shop.create!(name: "Aritzia", 
            url: "http://www.aritzia.com")
Shop.create!(name: "Zara", 
            url: "http://www.zara.com/us/")
Shop.create!(name: "TopShop", 
            url: "http://www.topshop.com")
Shop.create!(name: "Anthropologie", 
            url: "http://www.anthropologie.com")
Shop.create!(name: "Loft", 
            url: "http://www.loft.com")
Shop.create!(name: "Nasty Gal", 
            url: "http://www.nastygal.com")
Shop.create!(name: "Bloomingdales", 
            url: "http://www.bloomingdales.com")
Shop.create!(name: "Need Supply Co.", 
            url: "http://www.needsupply.com")
Shop.create!(name: "Urban Outfitters", 
            url: "http://www.urbanoutfitters.com")
Shop.create!(name: "Gap", 
            url: "http://www.gap.com")
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

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

shops = Shop.order(:created_at).take(6) #add 20 posts to first 6 shops
20.times do
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

shop_posts = ShopPost.all
6.times do
  name = Faker::Commerce.product_name
  price = Faker::Commerce.price
  main_img_url = "https://i.s-madewell.com/is/image/madewell/F9669_DM1517_m?$pdp_fs418$"
  shop_posts.each do |shop_post| 
    #create the item for the shop_post
    shop_post.items.create!(name: name, 
    price: price, 
    main_img_url:main_img_url, 
    thumbnail_img_url: main_img_url, 
    description: Faker::Lorem.sentence(10)) 
  end
end

#crawl the stores for their new arrivals page to get 1 post per store, 
# each containing 6 items from their respective new arrivals page
#shops = Shop.all
agent = Mechanize.new
shop = Shop.first 
puts "scraping shop:"
puts shop.name
page = agent.get(shop.url)
puts page
link = page.xpath('//a[contains(text(), "NEW ARRIVALS")]')
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "New Arrivals")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "new arrivals")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "NEW IN")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "New In")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "new in")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "NEW")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "New")]')
end
if link == nil || link.length == 0
  link = page.xpath('//a[contains(text(), "new")]')
end
new_page = agent.get(link.first.attribute("href")) #get new arrivals page

items = new_page.search('a img') #returns nokogiri NodeSet
per_post = 0
num_items = 0
content = Faker::Lorem.sentence(10)
shop_post = shop.shop_posts.create!(content: content)

#for each item, add to a post (get pics, info, etc. in the process)
items.each do |item| 
  product_url = item.xpath("ancestor::a[1]").attribute("href") #link to product page
  item_page = agent.get(product_url) #get product page
  item_imgs = item_page.xpath('//img') #returns all images on item page
  #find large pixel item + set as main_img_url
  thumbnail_img_url = item.attribute("src").to_s #for thumbnail on feed page
  if (thumbnail_img_url == nil || !thumbnail_img_url.start_with?("http"))
    puts "skipping this item below"
    next
  end
  puts "thumbnail_img_url: " << thumbnail_img_url
  main_img_url = item.attribute("src").to_s #backup thumbnail as main_img_url
  item_imgs.each do |item_img|
    size = item_img.attribute("size").to_s
    width = item_img.attribute("width").to_s
    height = item_img.attribute("height").to_s
    if size != nil && size.to_i > 350
      main_img_url = item_img.attribute("src")
      break
    end 
    if width != nil && width.to_i > 350
      main_img_url = item_img.attribute("src")
      break
    end
    if height != nil && height.to_i > 350
      main_img_url = item_img.attribute("src")
      break
    end
  end

  num_items = num_items + 1
  name = "item "<< num_items
  if (main_img_url != nil && main_img_url.to_s.length != 0) 
    per_post = per_post + 1
    if (per_post > 5)
      shop_post.save #save current shop_post state w/ 6 items
      shop_post = shop.shop_posts.create!(content: content) #create new shop_post
      shop_post.items.create!(
        name: name, 
        price: $0, 
        product_url: product_url, 
        thumbnail_img_url: thumbnail_img_url,
        main_img_url: main_img_url,
        description: Faker::Lorem.sentence(10)) #add curr item to this new shop_post
      per_post = 0
    else  
      shop_post.items.create!(
        name: name, 
        price: $0, 
        product_url: product_url,
        thumbnail_img_url: thumbnail_img_url,
        #thumbnail_img_file: URI.parse(thumbnail_img_url).read,
        main_img_url: main_img_url, 
        #main_img_file: URI.parse(main_img_url).open.read,
        description: Faker::Lorem.sentence(10))
    end
  end

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




