module AuthHelper
  include Capybara::DSL

  def mock_login
    OmniAuth.config.add_mock(:github, {
      'uid' => "1337",
      'info' => {
        'name' => "Jon Rogozen",
        'email' => "jonrogozen@gmail.com"
      }
    })
    visit "/sign_in"
    find("button", text: "github login").click
  end

  def adminify(user)
    binding.pry
    user.id = 1
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