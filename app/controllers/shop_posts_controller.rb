class ShopPostsController < ApplicationController
	before_action :admin_user,     only: :edit_shop_post

	def update
		@shop = Shop.find(params[:id])
		@user = User.find(params[:id])
		@shop_post = ShopPost.find(params[:id])
	    if @shop_post.update_attributes(shop_post_params)
	    	# Handle a successful update.
	      	flash[:success] = "Successfully Saved Shop Post Image" 
	      	redirect_to @shop 
	    end
	end

	def show
		@user = User.find(params[:id])
		@shop = Shop.find(params[:id])
	end

	private
		def shop_post_params
			params.require(:shop_post).permit(:content, :picture)
	    end

end
