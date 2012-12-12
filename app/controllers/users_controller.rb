class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user, 	   only: [:index, :destroy]

  	def show
		@user = User.find(params[:id])
	end
 	
	def new
		@user = User.new
	end
	
	def create 
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Electronic Bulletin Board!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit 
	end

	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def index
		@users = User.all
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

	private

	def signed_in_user
		unless signed_in?
			store_location
			redirect_to signin_url, flash: {error: "Not signed in"}
		end
	end

	def correct_user
		flash[:error] = "Wrong user" 
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

	def admin_user
		unless current_user.admin?
			redirect_to root_path, flash: {error: "Not an administrator"}
		end
	end
end
