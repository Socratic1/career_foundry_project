class WishesController < ApplicationController

	def index
		@wishes = Wishes.find_by_user_id(current_user.id)
	end

	def show
		@user = current_user
		@products = @user.wish_list.products.order("created_at DESC")
	end

	def create
		@wish = current_user.wishes.new
		@wish.product = Product.find(params[:product_id])
		respond_to do |format|
			if @comment.save
				format.html { redirect_to @product, notice: 'You have added #{@wish.product} to your wish list.' }
				format.json { render :show, status: :created, location: @product }
			else
				format.html { redirect_to @product, alert: 'Wish was not created succesfully.' }
				format.json { render json: @wish.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
	end
end