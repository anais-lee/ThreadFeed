class RelationshipsController < ApplicationController
	before_action :logged_in_user

	def create
		shop = Shop.find(params[:followed_id])
		current_user.follow(shop)
		redirect_to shop
	end

	def destroy
		shop = Relationship.find(params[:id]).followed
		current_user.unfollow(shop)
		redirect_to shop
	end

	# Confirms a logged-in user.
	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end
end
