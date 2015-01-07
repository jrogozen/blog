require 'rails_helper'

feature "Create new post", js: true do
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
  end

  scenario "redirects to new post" do
    click_on 'New Post'
    fill_in "name", with: "Testing is Fun"
    fill_in "content", with: "An app without testing is like milk tea without boba."
    click_on "Create"
    expect(page).to have_content("Testing is Fun")
    expect(page).to have_content("An app without testing is like milk tea without boba.")
  end

  scenario "errors if post has no name" do
    click_on 'New Post'
    fill_in "content", with: "this won't work"
    click_on "Create"
    expect(page).to have_content("Oops, you forgot to add a name for the post")
  end
end