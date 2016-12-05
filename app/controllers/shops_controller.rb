class ShopsController < ApplicationController
	before_action :admin_user,     only: :destroy

	def new
	end

	def show
		@shop = Shop.find(params[:id])
		@shop_posts = @shop.shop_posts.paginate(page: params[:page])
	end

	def index
		@user = current_user
		@shops = Shop.paginate(:page => params[:page])
	end

	def destroy
		Shop.find(params[:id]).destroy
    	flash[:success] = "Shop deleted"
    	redirect_to shops_url
	end

	private
		# Confirms an admin user.
	    def admin_user
	      	(root_url) unless current_user.admin?
	    end
end
