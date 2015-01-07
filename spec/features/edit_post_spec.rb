require 'rails_helper'

feature "Edit post", js: true do
  before do
    login_data = {
      strategy: 'github',
      data: {
        name: "Jon Rogozen",
        email: "jon.rogozen@gmail.com",
        uid: 1337
      }
    }

    mock_login(login_data)
    adminify(User.first)
        
    Post.create!(name: 'Setting Up Rails 4 & Angular')
    Post.create!(name: 'Testing a Rails & Angular App')
  end

  scenario "Updates post" do
    click_on 'Setting Up Rails 4 & Angular'
    click_on 'Edit'
    fill_in "name", with: "Setting Up Rails 5 & Angular"
    fill_in "content", with: "Better luck tomorrow."
    click_on "Edit"
    expect(page).to have_content("Setting Up Rails 5 & Angular")
    expect(page).to have_content("Better luck tomorrow.")
    expect(page).not_to have_content("Setting Up Rails 4 & Angular")
  end
end