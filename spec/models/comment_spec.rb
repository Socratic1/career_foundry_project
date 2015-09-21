require 'rails_helper'

describe Comment do
	
	context "body missing" do

		before do 
            @user = User.new(
            	email: "example@example.com", 
            	password: "examplepass",
            	password_confirmation: "examplepass"
            )			
            @product = Product.new(name: "Example product")
			@comment = Comment.new(
				user: @user.id, 
				product: @product.id, 
				rating: 5
			)
		end

		it "should raise body presence validation error" do
			@comment.valid?
			expect(@comment.errors[:body]).to include("can't be blank")
		end
	end

	context "user id missing" do

		before do
			@product = Product.new(name: "Example product")
			@comment = Comment.new(
				product: @product.id, 
				body: "Example comment", 
				rating: 5
			)
		end

		it "should raise user id presence validation error" do
			@comment.valid?
			expect(@comment.errors[:user]).to include("can't be blank")
		end
	end

	context "product id missing" do

		before do
            @user = User.new(
            	email: "example@example.com", 
            	password: "examplepass",
            	password_confirmation: "examplepass"
           	)			
            @comment = Comment.new(
            	user: @user.id, 
            	body: "Example comment", 
            	rating: 5
           	)
		end

		it "should raise product id presence validation error" do
			@comment.valid?
			expect(@comment.errors[:product]).to include("can't be blank")
		end
	end

end