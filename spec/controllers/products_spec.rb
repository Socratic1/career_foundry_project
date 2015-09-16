require 'rails_helper'

describe ProductsController, :type => :controller do 

	context "user logged in" do

		describe "GET /products/new" do
			it "responds successfully with an HTTP 200 status code" do
				get :new
				expect(response).to be_success
				expect(response).to have_http_status(200)
			end

			it "renders the index template" do
				get :new
				expect(response).to render_template("products/new")
			end
		end
	end

	
end