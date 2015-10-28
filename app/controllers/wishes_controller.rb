class WishesController < ApplicationController

	def index
		@wishes = Wish.where("user_id = ?", "#{current_user.id}")
	end

	def show
		@user = current_user
		@products = @user.wish_list.products.order("created_at DESC")
	end

	def create
		@product = Product.find(params[:product_id])
		if Wish.where(user_id: "#{current_user.id}", product_id: "#{@product.id}").exists?
			@wish = Wish.where(user_id: "#{current_user.id}", product_id: "#{@product.id}").first
			@wish.total += 1

		else
			@wish = @product.wishes.new
			@wish.user = current_user
			@wish.total = 1
		end
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

	def destroy
		case i = params[:i]
		when @wish.total > i
			@wish.total -= i
			respond_to do |format|
      			format.html { redirect_to action: 'index', notice: 'You removed the item from your wish-list.' }
      			format.json { head :no_content }
    		end
		when @wish.total == i
			@wish.destroy
			respond_to do |format|
      			format.html { redirect_to action: 'index', notice: 'You removed the item from your wish-list.' }
      			format.json { head :no_content }
    		end
    	else
    		format.html { redirect_to action: 'index', alert: 'You cannot remove more items than you have on your list.' }
      		format.json { head :no_content }
		end

	end
end