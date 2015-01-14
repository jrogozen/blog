require 'rails_helper'

feature "Delete post", js: true do
  before do
    mock_login
    adminify(User.first)

    Post.create!(name: 'Setting Up Rails 4 & Angular')
  end

  scenario "Deletes post" do
    click_on 'Setting Up Rails 4 & Angular'
    click_on 'Delete'
    expect(page).not_to have_content("Setting Up Rails 4 & Angular")
  end
end