require 'rails_helper'

	describe ProductsController, :type => :controller do
		render_views

		before do
			@product = create(:product)
        end


		context "user logged in" do

			before do
				@user = create(:user)  
				sign_in :user, @user
			end


			context "get /products" do
				context "search query passed" do

					before do
						search_term = "Example bike"
						@products = Product.where("name LIKE ?", "%#{search_term}")
					end

					it "GET /products" do
						get :index
						expect(response).to be_success
						expect(response).to have_http_status(200)
					end

					it "renders index template" do
						get :index
						expect(response).to render_template :index
					end
				end

				context "no search made" do

					before do
						@products = Product.all
					end

					it "responds successfully with an HTTP 200 status code" do
						get :index
						expect(response).to be_success
						expect(response).to have_http_status(200)
					end

					it "renders index template" do
						get :index
						expect(response).to render_template :index
					end
				end
			end



			context "GET /products/1" do
				it "responds successfully" do
						expect(response).to be_success
						expect(response).to have_http_status(200)
				end

				it "renders the products/@product.id template" do
					get :show, id: @product.id
					expect(response).to render_template :show
				end
			end

			context "GET /products/new" do
				it "responds successfully with an HTTP 200 status code" do
					get :new
					expect(response).to be_success
					expect(response).to have_http_status(200)
				end

				it "renders the /products/new template" do
					get :new
					expect(response).to render_template("products/new")
				end
			end

			context "GET /products/1/edit" do
			end

			context "POST /products" do
				it "successfully creates new product" do
					expect{ post :create, product: { name: "Example Product" } }.to change{ Product.count }.by(1)
					assert_redirected_to product_path(assigns(:product))
				end
			end

			context "PATCH /products/1" do
				it "edits @product" do
					get :edit, id: @product
					assert_response :success
				end
			end

			context "DELETE /products/1" do
				it "deletes @product" do
					expect{ delete :destroy, id: @product }.to change{ Product.count }.by(-1)
					assert_redirected_to products_path
				end
			end
		end

		context "no user logged in" do

			before do
				current_user = nil
			end

			context "GET /products" do
				it "responds unsuccessfully with redirect to login" do
					get :index
					expect(response).to have_http_status(302)
					assert_redirected_to new_user_session_path
				end
			end
		end

	end
