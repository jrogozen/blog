Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], 
    scope: 'email,profile'
    # redirect_uri: ENV['GITHUB_REDIRECT']
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end