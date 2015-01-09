require 'rails_helper'

feature 'Authentication', js: true do
  before do
    mock_login
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