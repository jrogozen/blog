Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], 
    scope: 'email,profile', 
    provider_ignores_state: true,
    redirect_uri: ENV['GITHUB_REDIRECT']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end