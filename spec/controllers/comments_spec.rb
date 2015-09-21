require 'rails_helper'

RSpec.configure do |config|
	config.include Devise::TestHelpers, type: :controller
	describe CommentsController, :type => :controller do
		render_views

		before do
			@user = User.create(
                email: "example@example.com", 
                password: "examplepass",
                password_confirmation: "examplepass"
            ) 
			@product = Product.create(name: "Example Bike")
			@comment = @product.comments.create(
				user: @user,
                rating: 5, 
                body: "Test comment"
            )

        end

		context "GET /products/1" do
			it "responds successfully" do
					expect(response).to be_success
					expect(response).to have_http_status(200)
			end

			it "renders the products/@product.id template" do
				get :show, id: @product
				expect(response).to render_template :show
			end
		end

		context "create comment" do
			it "successfully creates new product" do
				expect{ 
					post :create, 
					comment: { 
						product: @product,
						user: @user,
						rating: 5,
						body: "Test comment"
					} 
				}.to change{ @product.comments.count }.by(1)
				assert_redirected_to product_path(assigns(:product))
			end
		end

		context "destroy comment" do
			context "logged in as admin" do

				before do
					@user = User.create(
                		email: "example@example.com", 
                		password: "examplepass",
                		password_confirmation: "examplepass",
                		admin: true
            		) 
            		sign_in :user, @user
				end

				it "deletes @comment" do
					expect{ delete :destroy, id: @comment }.to change{ Comment.count }.by(-1)
					assert_redirected_to product_path(assigns(:product))
				end
			end

			context "not logged in as admin" do

			end
		end
	end

end

