if Rails.env.production?
	Rails.configuration.stripe = {
	    :publishable_key => 'pk_test_oaLwIT5RZOrZJkMNF8baC9R0',
	    :secret_key => 'sk_test_cAIasZ0q7hi6a22jrbdXzx6W'
	}
else
    Rails.configuration.stripe = {
    	:publishable_key => 'pk_test_oaLwIT5RZOrZJkMNF8baC9R0',
    	:secret_key => 'sk_test_cAIasZ0q7hi6a22jrbdXzx6W'
    }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]