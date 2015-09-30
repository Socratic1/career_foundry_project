FactoryGirl.define do 

	factory :comment do
		rating 5
		body "Test comment"

		product
		user
	end

	factory :product do
		name "Test product"
		description "For testing"
		image_url "example.jpg"
		colour "red"
	end

	factory :user do
		email "example@example.com"
		password "examplepass"
		admin false

	end


	factory :admin, parent: :user do
		admin true
	end
end