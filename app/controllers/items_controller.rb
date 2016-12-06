class ItemsController < ApplicationController

	def show 
		@item = Item.find(params[:id])
		@shop_post = ShopPost.find(@item.shop_post_id)
		@shop = Shop.find(@shop_post.shop_id)
	end 

end
