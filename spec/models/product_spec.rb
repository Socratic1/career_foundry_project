require 'rails_helper'

describe Product do 
    
    context "name, description, image_url, and colour present" do

    	before { @product = Product.new(name: "Example Bike", description: "For testing",
    		                            image_url: "example.jpg", colour: "red") }

    	it "should return product name, description, image_url, and colour" do
    		expect(@product.name).to eq("Example Bike")
    		expect(@product.description).to eq("For testing")
    		expect(@product.image_url).to eq("example.jpg")
    		expect(@product.colour).to eq("red")
    	end
	end

    context "name missing" do

        before { @product = Product.new(description: "For testing", image_url: "example.jpg",
                                        colour: "red") }

        it "should raise name presence validation error" do
            expect { @product.save }.to raise_error("can't be blank")
        end
    end

    context "five ratings given to @product" do

        before do
            @user = User(email: "example@example.com", password: "examplepass",
                         password_confirmation: "examplepass").create            
            @product = Product.new(name: "Example Bike", description: "For testing",
                                        image_url: "example.jpg", colour: "red")
            @comment1 = Comment.new(user: @user.id, product: @product.id,
                                   rating: 5, body: "Test comment")
            @comment2 = Comment.new(user: @user.id, product: @product.id,
                                   rating: 4, body: "Test comment")
            @comment3 = Comment.new(user: @user.id, product: @product.id,
                                   rating: 2, body: "Test comment")
            @comment4 = Comment.new(user: @user.id, product: @product.id,
                                   rating: 3, body: "Test comment")
            @comment5 = Comment.new(user: @user.id, product: @product.id,
                                   rating: 0, body: "Test comment")
        end

        it "should return the average rating for @product" do
            expect(comments.average(:rating)).to equal((5+4+2+3)/5)
    
        end
    end
end