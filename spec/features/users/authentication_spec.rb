require 'rails_helper'

feature 'Authentication', js: true do
  before do
    login_data = {
      strategy: 'github',
      data: {
        name: "Ted Mosby",
        email: "tedmosby@gmail.com",
        uid: 1337
      }
    }

    mock_login(login_data)
  end

  feature 'login' do
    scenario 'with valid input' do
      expect(page).to have_content("Sign out")
    end

    scenario 'redirect after login' do
      expect(page).to have_content("Homepage")
    end

    scenario 'is not an admin' do
      expect(page).not_to have_content("Admin Panel")
    end
  end
end