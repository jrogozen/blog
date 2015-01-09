require 'rails_helper'

feature "Create new post", js: true do
  before do
    mock_login
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
    expect(page).to have_content("Name can't be blank")
  end
end