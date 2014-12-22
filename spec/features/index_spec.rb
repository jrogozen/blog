require 'rails_helper'

feature "Looking up posts", js: true do
  before do
    Post.create!(name: 'Setting Up Rails 4 & Angular')
    Post.create!(name: 'Testing a Rails & Angular App')
    Post.create!(name: 'New Job As a Web QA Analyst')
    Post.create!(name: 'Thanks, MakerSquare')
  end
  scenario "displays posts on homepage" do
    visit '/'
    # fill_in "keywords", with: "Testing"
    # click_on "Search"
    expect(page).to have_content("Testing a Rails & Angular App")
  end
end