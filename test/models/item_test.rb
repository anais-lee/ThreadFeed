require 'test_helper'

class ItemTest < ActiveSupport::TestCase
	def setup
		@shop_post = shop_posts(:orange)
		@item = @shop_post.items.build(name: "Item 1", price:"$58.00", 
	    	main_img_url: "www.test.com/image.png")
	end

	test "should be valid1" do
		assert @item.valid?
	end

	test "item name should be present" do
		@item.name = nil
		assert_not @item.valid?
	end
	test "item price should be present" do
		@item.price = nil
		assert_not @item.valid?
	end
	test "item img should be present" do
		@item.main_img_url = nil
		assert_not @item.valid?
	end
	test "order should be most recent first" do
	    assert_equal items(:four), Item.first
	end
end
