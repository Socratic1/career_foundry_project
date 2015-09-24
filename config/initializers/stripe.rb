if Rails.env.production?
	Rails.configuration.stripe = {
	    :publishable_key => ENV['pk_live_I4QWiic3kDy7RaLxMy6VaDIp'],
	    :secret_key => ENV['sk_live_bBiphgwI9ClXruEWqZDFsPgH']
	}
else
    Rails.configuration.stripe = {
    	:publishable_key => 'pk_test_SlTylXi4BMo0QI1vcjz8ucVa',
    	:secret_key => 'sk_test_cAIasZ0q7hi6a22jrbdXzx6W'
    }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]