class PaymentsController < ApplicationController

	def create
		@product = Product.find(params[:product_id])
		@user = current_user

		token = params[:stripeToken]
		customer = Stripe::Customer.create(
			:source => token,
			:email => @user.email
		)

		redirect_to new_order_url(:user_id => @user.id, 
								  :product_id => @product.id,
								  :customer_id => customer.id
		)
	end


end
