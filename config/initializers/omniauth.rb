Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Twitter.consumer_key, Twitter.consumer_secret
end
