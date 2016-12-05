require 'test_helper'

class ShopPostTest < ActiveSupport::TestCase

  def setup
    @shop = shops(:madewell)
    # This code is not idiomatically correct.
    @shop_post = @shop.shop_posts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @shop_post.valid?
  end

  test "user id should be present" do
    @shop_post.shop_id = nil
    assert_not @shop_post.valid?
  end

  test "content should be present" do
    @shop_post.content = "   "
    assert_not @shop_post.valid?
  end

  test "content should be at most 140 characters" do
    @shop_post.content = "a" * 141
    assert_not @shop_post.valid?
  end

   test "order should be most recent first" do
    assert_equal shop_posts(:most_recent), ShopPost.first
  end

  test "associated items should be destroyed" do
    @shop_post.save
    @shop_post.items.create!(name: "Item 1", price:"$58.00", 
        main_img_url: "www.test.com/image.png")
    assert_difference 'Item.count', -1 do
      @shop_post.destroy
    end
  end


end