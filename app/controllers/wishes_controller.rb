class WishesController < ApplicationController

	def index
		@wishes = Wish.all(user: { id: current_user.id })
	end

	def show
		@user = current_user
		@products = @user.wish_list.products.order("created_at DESC")
	end

	def create
		@product = Product.find(params[:product_id])
		@wish = @product.wishes.new
		@wish.user = current_user
		respond_to do |format|
			if @wish.save
				format.html { redirect_to action: "index", notice: 'You have added <%= @wish.product %> to your wish list.' }
				format.json { render :index, status: :created }
			else
				format.html { redirect_to @product, alert: 'Wish was not created succesfully.' }
				format.json { render json: @wish.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
	end
end