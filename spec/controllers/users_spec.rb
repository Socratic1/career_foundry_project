require "rails_helper"

	describe UsersController, :type => :controller do 

		before do
			@user = create(:user, email: "user@example.com")
		end

		describe "GET #show" do
			context "User is logged in" do

				before do
					sign_in :user, @user
				end

				it "responds successfully with a HTTP 200 status code" do
					get :show, id: @user.id
					expect(response).to be_success
					expect(response).to have_http_status(200)
				end

				it "assigns the correct user" do
					get :show, id: @user.id
					expect(assigns(:user)).to eq @user
				end
			end

			context "No user is logged in" do
				it "redirects to login" do
					get :show, id: @user.id
					expect(response).to redirect_to(root_path)
				end
			end

			context "Another user is logged in" do

				before do
					@user1 = create(:user, email: "user1@example.com")
					sign_in :user, @user
				end

				it "redirects to login" do
					get :show, id: @user1.id
					expect(response).to redirect_to(root_path)
				end
			end
		end
	end