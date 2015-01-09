require 'rails_helper'

feature "Create new category", js: true do
  before do    
    mock_login
    adminify(User.first)

    Category.create!(name: "Ruby")
  end

  scenario "redirects to categories page" do
    click_on 'Categories'
    click_on 'New Category'
    fill_in "name", with: "Books"
    click_on "Create"
    expect(page).to have_content("All Categories")
    expect(page).to have_content("Books")
  end

  scenario "errors if category has no name" do
    click_on "Categories"
    click_on "New Category"
    fill_in "name", with: ""
    click_on "Create"
    expect(page).to have_content("Name can't be blank")
  end

  scenario "errors if category name exists" do
    click_on 'Categories'
    click_on 'New Category'
    fill_in "name", with: "Ruby"
    click_on "Create"
    expect(page).to have_content("Name has already been taken")
  end
end