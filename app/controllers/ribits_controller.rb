class RibitsController < ApplicationController
	
	def index
		@ribits = Ribit.all incluse: :user
		@ribit = Ribit.new
	end

	def create
		@ribit = Ribit.new(params[:ribit])
		@ribit.userid = current_user.id

		if @ribit.save
			redirect_to current_user
		else
			flash[:error] = "Problem!"
			redirect_to current_user
		end
	end
end
