Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["twitter_consumer_key"], ENV["twitter_consumer_secret"]
end

if Rails.env == 'development' || Rails.env == 'test'
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    provider: 'twitter',
    extra: {
      raw_info: {
        user_id: "1234",
        name: "Horace",
        screen_name: "worace",
      }
    },
    credentials: {
      token: "pizza",
      secret: "secretpizza"
    }
  })
end
