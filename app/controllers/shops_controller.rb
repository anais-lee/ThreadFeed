class ShopsController < ApplicationController
	def new
	end

	def show
		@shop = Shop.find(params[:id])
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
end
