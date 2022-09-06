IEX::Api.configure do |config| 
	config.publishable_token = Rails.application.credentials.iex.production[:publishable_token]
	config.secret_token = Rails.application.credentials.iex.production[:secret_token]
	config.endpoint = Rails.application.credentials.iex.production[:endpoint]
end

