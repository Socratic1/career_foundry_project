class PaymentsController < ApplicationController

	def create
		@product = Product.find(params[:product_id])

		token = params[:stripeToken]
		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
				:amount => @product.amount, #amount in cents, again
				:currency => "eur",
				:source => token, 
				:description => params[:stripeEmail]
				)

			@order = @product.order.build
			@order.user = current_user

			@email = @user[:email]
			@message = "Thank for you purchasing the #{ @product[:name] }."
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
		redirect_to product_path(product)
	end


end
