require 'rails_helper'

RSpec.configure do |config|
	config.include Devise::TestHelpers, type: :controller
	describe CommentsController, :type => :controller do
		render_views

		before do
			@user = create(:user)
			@product = create(:product)
			@comment = @product.comments.create(
				user: @user,
				product: @product,
                rating: 5, 
                body: "Test comment"
            )

        end

		context "show comments" do
			it "responds successfully" do
			end

			it "renders the products/@product.id template" do
			end
		end

		context "create comment" do
			it "successfully creates new comment" do
				expect{ 
					post :create,
					product_id: @product.id, 
					comment: {
						user: @user, 
						rating: 5, 
						body: "Test Comment"
					}
				}.to change{ @product.comments.count }.by(1)
				assert_redirected_to product_path(assigns(:product))
			end
		end

		context "destroy comment" do
			context "logged in as admin" do

				before do
					@user = create(:user, email: "example2@example.com")
            		sign_in :user, @user
				end

				it "deletes @comment" do
					expect{ 
						delete :destroy, 
						product_id: @product.id, 
						comment: @comment 
					}.to change{ Comment.count }.by(-1)
					assert_redirected_to product_path(assigns(:product))
				end
			end

			context "not logged in as admin" do
				before do
					@user = create(:admin)
            		sign_in :user, @user
				end

				it "deletes @comment" do
					expect{ delete :destroy, id: @comment }.to change{ Comment.count }.by(-1)
					assert_redirected_to product_path(assigns(:product))
				end

			end
		end
	end

end

