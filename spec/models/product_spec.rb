require 'rails_helper'

describe Product do 
    
  context "name missing" do

        before do
            @product = Product.new(
                description: "For testing",
                image_url: "example.jpg", 
                colour: "red"
            ) 
        end

        it "should raise name presence validation error" do
            @product.valid?
            expect(@product.errors[:name]).to include("can't be blank")
        end
    end

    context "five ratings given to @product" do

        before do
            @user = User.new(
                email: "example@example.com", 
                password: "examplepass",
                password_confirmation: "examplepass"
            )       
            @product = Product.create(
                name: "Example Bike", 
                description: "For testing",
                image_url: "example.jpg", 
                colour: "red"
            )

#           for loop
            comment1 = @product.comments.create(
                user: @user,
                rating: 5, 
                body: "Test comment"
            )
            comment2 = @product.comments.create(
                user: @user, 
                rating: 4, 
                body: "Test comment"
            )
            comment3 = @product.comments.create(
                user: @user, 
                rating: 2, 
                body: "Test comment"
            )
            comment4 = @product.comments.create(
                user: @user, 
                rating: 3, 
                body: "Test comment"
            )
            comment5 = @product.comments.create(
                user: @user, 
                rating: 0, 
                body: "Test comment"
            )
        end

        it "should return the average rating for @product" do
            expect(@product.comments.average(:rating).to_f).to eq((5.0 + 4 + 2 + 3) / 5.0)
        end
    end
end