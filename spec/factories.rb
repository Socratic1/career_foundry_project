FactoryGirl.define do 

	factory :comment do
		rating 5
		body "Test comment"
	end

	factory :product do
		name "Test product"
		description "For testing"
		image_url "example.jpg"
		colour "red"

		factory :product_with_comments do
			transient do
				comment_count 5
			end

			after(:create) do |product, evaluator|
				create_list(:comment, evaluator.comment_count, product: product)
			end
		end
	end

	factory :user do
		email "example@example.com"
		password "examplepass"
		admin false

		factory :user_with_comments do
			transient do
				comments_count 5
			end

			after(:create) do |user, evaluator|
				create_list(:comment, evaluator.comment_count, user: user)
			end
		end

		factory :user_with_products do
			transient do
				product_count 1
			end

			after(:create) do |user, evaluator|
				create_list(:product, evaluator.product_count, user: user)
			end
		end
	end


	factory :admin, parent: :user do
		admin true
	end
end