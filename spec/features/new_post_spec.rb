require 'rails_helper'

feature "Create new post", js: true do
  before do
    mock_login
    adminify(User.first)

    Category.create!(name: "Ruby", id: 1)
    Category.create!(name: "Books", id: 2)
    Category.create!(name: "General", id: 3)
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

  scenario "assigns correct categories" do
    click_on "New Post"
    fill_in "name", with: "The Great Gatsby"
    fill_in "content", with: "Great Gatsby is great"
    select "Books", from: "category"
    click_on "Create"
    expect(page).to have_content("posted in Books")
  end

  scenario "assigns default category" do
    click_on "New Post"
    fill_in "name", with: "My First Day"
    fill_in "content", with: "Sucks"
    click_on "Create"
    expect(page).to have_content("posted in General")
  end
end