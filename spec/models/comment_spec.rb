require 'rails_helper'

describe Comment do

	before do
		@user = create(:user, email: "commenting_user@example.com")		
        @product = create(:product)
    end
	
	context "body missing" do
		before do 
			@comment = build(:comment, body: nil, user: @user, product: @product)
		end

		it "should raise body presence validation error" do
			@comment.valid?
			expect {@comment.save!}.to raise_error(
				ActiveRecord::RecordInvalid, "Validation failed: Body can't be blank"
			)
		end
	end

	context "user id missing" do

		before do
			@comment = build(:comment, user: nil, product: @product)
		end

		it "should raise user id presence validation error" do
			@comment.valid?
			expect {@comment.save!}.to raise_error(
				ActiveRecord::RecordInvalid, "Validation failed: User can't be blank"
			)
		end
	end

	context "product id missing" do

		before do
			@comment = build(:comment, user: @user, product: nil)
		end

		it "should raise product id presence validation error" do
			@comment.valid?
			expect {@comment.save!}.to raise_error(
				ActiveRecord::RecordInvalid, "Validation failed: Product can't be blank"
			)
		end
	end

end