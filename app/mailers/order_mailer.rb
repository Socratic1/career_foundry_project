class OrderMailer < ApplicationMailer

	def order_confirmation(product, email, name)
		@product = product
		@name = name
		mail(:from => 'samuel.rodney.phillips@gmail.com', 
			   :to => email,
		  :subject => "#{name}, your order has been completed.")
	end
end
