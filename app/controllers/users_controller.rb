class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def create #called when form is submitted on signup page
		@user = User.new(user_params)  #not in the final impl
		if @user.save
			log_in @user
			flash[:success] = "Welcome to ThreadFeed!"
      		redirect_to @user
  		else
  			render 'new'
  		end
	end

	private
		def user_params
	      params.require(:user).permit(:name, :email, :password,
	                                   :password_confirmation)
	    end
end
