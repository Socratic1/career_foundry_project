class OrdersController < ApplicationController

	def index
	end

	def show
	end

	def new
		@order = Order.new
		@order.user = User.find(params[:user_id])
		@order.product = Product.find(params[:product_id])

	end

	def create
		@order = Order.new(order_params)

    	respond_to do |format|
      		if @order.save
        		format.html { redirect_to @order, notice: 'Your order was successful.' }
        		format.json { render :show, status: :created, location: @order }
      		else
        		format.html { render :new }
        		format.json { render json: @order.errors, status: :unprocessable_entity }
      		end
    	end
	end

end