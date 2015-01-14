require 'rails_helper'

feature "Delete post", js: true do
  before do
    mock_login
    adminify(User.first)

    Category.create!(name: "Blah")
    Category.create!(name: "Bah")
  end

  scenario "Deletes Category" do
    click_on 'Categories'
    click_on "delete"

    expect(page).to have_content("Category deleted")
  end
end