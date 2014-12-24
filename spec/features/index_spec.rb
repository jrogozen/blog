require 'rails_helper'

feature "Render homepage", js: true do
  before do
    Post.create!(name: 'Setting Up Rails 4 & Angular')
    Post.create!(name: 'Testing a Rails & Angular App')
  end

  scenario "displays posts on homepage" do
    visit '/'
    expect(page).to have_content("Testing a Rails & Angular App")
  end

  scenario "correctly links to create new post" do
    visit '/'
    click_on "New Post"
    expect(page).to have_content("Name")
    expect(page).to have_content("Create")
  end

end