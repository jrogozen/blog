require "rails_helper"

feature "Render Comments on Post Page", js: true do
  before do
    mock_login

    Post.create!(name: 'My Favorite Novel', id: 1)
    Comment.create!(content: "This novel is great.", post_id: 1, user_id: 1)
    Comment.create!(content: "This novel sucks.", post_id: 1, user_id: 1)
  end

  scenario "displays comments for correct post" do
    visit '/posts/1'
    expect(page).to have_content("This novel is great.")
    expect(page).to have_content("This novel sucks.")
  end
  
  scenario "displays comment author" do
    visit "/posts/1"
    expect(page).to have_content("@Jon Rogozen")
  end

  scenario "doesn't display wrong comments" do
    Post.create!(name: "My least favorite novel", id: 2)
    Comment.create!(content: "Woohoo", post_id: 2, user_id: 1)

    visit "/posts/2"
    expect(page).to have_content("Woohoo")
    expect(page).not_to have_content("This novel sucks.")
  end
end