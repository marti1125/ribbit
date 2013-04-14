class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
	    @user = User.find(params[:id])
	    @ribit = Ribit.new
	    @relationship = Relationship.where(
	    	follower_id: current_user.id,
	    	followed_id: @user.id
	    ).first_or_initlialize if current_user
	 end

	def new
		if current_user
			redirect_to buddies_path
		else
			@user = User.new
		end
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			session[:user_id] = @user.id
			redirect_to @user, notice: "Thank you for signing up for Ribbit!"
		else
			render 'new'
		end
	end

	def destroy
		@relationship = Relationship.find(params[:id])
		@relationship.destroy
		redirect_to user_path params[:id]
	end

	def buddies
		if current_user
			@ribit = Ribit.new
			buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
			@ribits = Ribit.find_all_by_user_id buddies_ids
		else
			redirect_to root_url
		end
	end

end
