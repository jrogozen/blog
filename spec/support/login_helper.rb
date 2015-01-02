class AuthHelper
  include Capybara::DSL

  def self.login(mock_login)
    strategy = mock_login[:strategy]
    OmniAuth.config.mock_auth[strategy.to_sym] = OmniAuth::AuthHash.new({
      :provider => strategy,
      :uid => mock_login[:data][:uid].to_s,
      :info => {
        'name' => mock_login[:data][:name],
        'email' => mock_login[:data][:email]
      }
    })
  end
end