class PaymentsController < ApplicationController

	def create
		token = params[:stripeToken]
		# Create the charge on Stripe's servers - this will charge the user's card
		begin
			charge = Stripe::Charge.create(
				:amount => params[:product.amount], #amount in cents, again
				:currency => "euro",
				:source => token, 
				:description => params[:product]
				)
		rescue Stripe::CardError => e
			# The card has been declined
			body = e.json_body
			err = body[:error]
			flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
		end
		redirect_to product_path(product)
	end


end
