require 'rails_helper'

feature "Delete post", js: true do
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
  end

  scenario "Deletes post" do
    click_on 'Setting Up Rails 4 & Angular'
    click_on 'Delete'
    expect(page).not_to have_content("Setting Up Rails 4 & Angular")
  end
end