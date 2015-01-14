require 'rails_helper'

feature 'Admin authentication', js: true do
  before do
    mock_login
    adminify(User.first)
  end

  feature 'login' do
    scenario 'with valid input' do
      expect(page).to have_content("Sign out")
    end

    scenario 'redirect after login' do
      expect(page).to have_content("Homepage")
    end

    scenario 'expect jon.rogozen to be an admin' do
      expect(page).to have_content("Admin Panel")
    end
  end
end