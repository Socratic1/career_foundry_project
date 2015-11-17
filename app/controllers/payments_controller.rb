class PaymentsController < ApplicationController

	def new
		@product = Product.find(params[:product_id])
		@user = current_user

		token = params[:stripeToken]
		@customer = Stripe::Customer.create(
			:source => token,
			:email => @user.email	
		)
	end

	def create
		@product = Product.find(params[:product_id])
		@customer = Stripe::Customer.retrieve(params[:customer_id])

		begin
            charge = Stripe::Charge.create(
                :amount => @product.amount, #amount in cents, again
                :currency => "eur",
                :description => params[:stripeEmail],
                :customer => @customer.id
            )

            if charge.paid
            	Order.create({:product_id => @product.id, :user_id => current_user.id, :total => @product.amount})
            end
        rescue Stripe::CardError => e
            # The card has been declined
            body = e.json_body
            err = body[:error]
            flash[:error] = "Unfortunately, there was an error processing your payment: #{err[:message]}"
        end

        redirect_to @product
        flash[:notice] = "Your purchase has been made successfully!"
	end
end



