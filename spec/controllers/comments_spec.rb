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

            before do
                sign_in :user, @user
            end

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
                    @admin = create(:admin, email: "example2@example.com")
                    sign_in :user, @admin
                end

                it "deletes @comment" do
                    expect{ 
                        delete :destroy, 
                        product_id: @product.id, 
                        id: @comment.id
                    }.to change{ Comment.count }.by(-1)
                    assert_redirected_to product_path(@comment.product.id)
                end
            end

            context "not logged in as admin" do
                before do
                    sign_in :user, @user
                    @comment1 = @product.comments.create(
                        user: @user,
                        rating: 5, 
                        body: "Test comment"
                    )
                end

                it "does not delete @comment" do
                    expect{ 
                        delete :destroy, 
                        product_id: @product.id, 
                        id: @comment.id
                    }.to change{ Comment.count }.by(0)
                    assert_redirected_to product_path(@comment.product.id)
                end

            end
        end
    end

end

