require 'rails_helper'

describe ProductsController, :type => :controller do 

	before do
		@product = products(:one)
	end

	context "user logged in" do

		before do
			@user = User.new(email: "example@example.com", password: "examplepass",
            			 password_confirmation: "examplepass")
			@user.save
		end

		context "search query passed" do

			describe "GET /products" do
			end

		end

		context "no search made" do

			describe "GET /products" do
			end

		end

		describe "GET /products/1" do
			it "renders the @product template" do
				get :show, id: @product
				assert_response :success
			end
		end

		describe "GET /products/new" do
			it "responds successfully with an HTTP 200 status code" do
				get :new
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end

			it "renders the index template" do
				get :new
				expect(response).to render_template("/new")
			end
		end

		describe "GET /products/1/edit" do
		end

		describe "POST /products" do
			it "successfully creates new product" do
				assert_difference('Product.count') do
					post :create, product: { title: "test product" }
				end

				assert_redirected_to product_path(assigns(:product))
			end
		end

		describe "PATCH /products/1" do
			it "edits @product" do
				get :edit, id: @product
				assert_response :success
			end
		end

		describe "DELETE /products/1" do
			it "deletes @product" do
				assert_difference('Product.count', -1) do
					delete :destroy, id: @product
				end

				assert_redirected_to product_path
			end
		end
	end

	context "no user logged in" do

		describe "GET /products" do
		end

		describe "GET /products/1" do
		end

		describe "GET /products/new" do
		end

		describe "GET /products/1/edit" do
		end

		describe "POST /products" do
		end

		describe "PATCH /products/1" do
		end

		describe "DELETE /products/1" do
		end
	end

end