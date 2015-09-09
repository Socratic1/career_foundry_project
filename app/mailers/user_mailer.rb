class UserMailer < ApplicationMailer
	default from: "from@example.com"

	def contact_form(email, name, message)
		@message = message
		mail(:from => email,
				:to => 'samuel.rodney.phillips@gmail.com',
				:subject => "A new contact from messagr from #{name}")
	end
end
