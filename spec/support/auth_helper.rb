module AuthHelper
  include Capybara::DSL

  def mock_login(mock_login)

    strategy = mock_login[:strategy]

    OmniAuth.config.add_mock(strategy.to_sym, {
      :uid => mock_login[:data][:uid].to_s,
      :admin => mock_login[:data][:admin],
      :info => {
        :name => mock_login[:data][:name],
        :email => mock_login[:data][:email]
      }
    })

    visit "/sign_in"
    find("button", text: "github login").click
  end

  def adminify(user)
    user.admin = true
    user.save
  end

  def mock_controller_headers
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @resource     = FactoryGirl.create(:confirmed_admin_user)
    @auth_headers = @resource.create_new_auth_token
    @client_id    = @auth_headers['client']
    age_token(@resource, @client_id)
    request.headers.merge!(@auth_headers) 
  end
end