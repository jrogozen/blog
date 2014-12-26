require 'rails_helper'

feature "Delete post", js: true do
  before do
    Post.create!(name: 'Setting Up Rails 4 & Angular')
  end
  scenario "Deletes post" do
    visit '/'
    click_on 'Setting Up Rails 4 & Angular'
    click_on 'Delete'
    expect(page).not_to have_content("Setting Up Rails 4 & Angular")
  end
end