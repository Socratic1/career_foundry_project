require 'rails_helper'

describe Comment do
	
	context "user id, product id, body, and rating present" do
		
		before do 
            @user = User(email: "example@example.com", password: "examplepass",
            			 password_confirmation: "examplepass").create
			@product = Product(name: "Example product").create
			@comment = Comment.new(user: @user.id, product: @product.id,
										   body: "Example comment", rating: 5)
		end

		it "should return comment user id, product id, body, and rating" do
			expect(@comment.user_id).to eq(@user.id)
			expect(@comment.product_id).to eq(@product.id)
			expect(@comment.body).to eq("Example comment")
			expect(@comment.rating).to eq(5)
		end
	end

	context "body missing" do

		before do 
            @user = User(email: "example@example.com", password: "examplepass",
            			 password_confirmation: "examplepass").create			
            @product = Product(name: "Example product").create
			@comment = Comment.new(user: @user.id, product: @product.id, rating: 5, body: "")
		end

		it "should raise body presence validation error" do
			expect { @comment.save }.to raise_error("can't be blank")
		end
	end

	context "user id missing" do

		before do
			@product = Product(name: "Example product").create
			@comment = Comment.new(product: @product.id, body: "Example comment", rating: 5)
		end

		it "should raise user id presence validation error" do
			expect { @comment.save }.to raise_error("can't be blank")
		end
	end

	context "product id missing" do

		before do
            @user = User(email: "example@example.com", password: "examplepass",
            			 password_confirmation: "examplepass").create			
            @comment = Comment.new(user: @user.id, body: "Example comment", rating: 5)
		end

		it "should raise product id presence validation error" do
			expect { @product.save }.to raise_error("can't be blank")
		end
	end

end