class UsersController < ApplicationController
	before_filter :require_login,  only: [:index, :edit]
	before_filter :correct_user,    only: [:show, :edit, :update, :create]
	before_filter :admin_user, 	    only: :destroy 

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
		#@users = User.paginate(page: params[:page])
		@users = User.all
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_url
	end

  def require_login
    unless signed_in?
      flash[:error] = "Not signed in" 
      redirect_to signin_path # Prevents the current action from running
    end
  end
	# PRIVATE FUNCTIONS 
	private

	def correct_user
		flash[:error] = "Wrong user" 
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

	def admin_user
		redirect_to(root_path) unless current_user.admin?
	end
end
