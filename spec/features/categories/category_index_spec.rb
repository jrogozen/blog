require 'rails_helper'

feature "Render Categories page", js: true do
  before do
    Category.create!(name: 'Books', id: 1)
    Category.create!(name: 'Ruby', id: 2)
    # Post.create!(name: 'My Favorite Novel', category_id: 1, id: 1)
    # Post.create!(name: 'My Favorite Script', category_id: 2, id: 2)
  end

  scenario "displays categories" do
    visit '/'
    click_on "Categories"
    expect(page).to have_content("Books")
    expect(page).to have_content("Ruby")
  end
end