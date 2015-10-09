class OrdersController < ApplicationController

	def index
	end

	def show
	end

	def new
		@order = Order.new
		@order.user = User.find(params[:user_id])
		@order.product = Product.find(params[:product_id])
		@customer = Stripe::Customer.retrieve(params[:customer_id])
	end

	def create
		@order = Order.new
		@order.product = Product.find(params[:product_id])
		@order.user = current_user

		respond_to do |format|
      		if @order.save
        		format.html { redirect_to @order.product, notice: 'Your order was successful.' }
        		format.json { render :show, status: :created, location: @order.product }
      		else
        		format.html { render :new }
        		format.json { render json: @order.errors, status: :unprocessable_entity }
      		end
    	end

		@customer = Stripe::Customer.retrieve(params[:customer_id])
		Rails.configuration.stripe[:publishable_key]
		begin
			charge = Stripe::Charge.create(
				:amount => @order.product.amount, #amount in cents, again
				:currency => "eur",
				:description => params[:stripeEmail],
				:customer => @customer.id,
				:metadata => {"order_id" => @order.id}
			)

			@email = @order.user[:email]
			@message = "Thank for you purchasing the #{ @order.product[:name] }."
			ActionMailer::Base.mail(:from => 'staff@leuvenbikes.com',
				:to => @email,
				:subject => 'Purchase Confirmation',
				:body => @message).deliver

		rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
		end
	end

end