require 'rails_helper'

describe Order do
	
	context "user id, product id, total present" do

		before do
            @user = User.new(email: "example@example.com", 
                         password: "examplepass",
                         password_confirmation: "examplepass")            
            @product = Product.new(name: "Example product")
            @order = Order.new(user: @user.id, 
                               product: @product.id, 
                               total: "30")
        end

        it "should return user id, product id, total" do
        	expect(@order.user).to eq(@user.id)
        	expect(@order.product).to eq(@product.id)
        	expect(@order.total).to eq(30)
		end
	end

end