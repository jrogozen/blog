require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  render_views

  before(:each) do
    mock_controller_headers
  end

  describe "GET index" do
    before do
      Post.create!(name: "Learn JS", category_id: 1, id: 1)
      Comment.create!(content: "My first comment.", post_id: 1, user_id: 1)
      Comment.create!(content: "My second comment.", post_id: 1, user_id: 1)
      get :index, post_id: 1
    end

    subject(:results) { JSON.parse(response.body) }

    context "when a post has comments" do
      it "should 200" do
        expect(response.status).to eq(200)
      end

      it "should return 2 results" do
        expect(results.size).to eq(2)
      end

      it "should include 'My first comment'" do
        expect(results.first["content"]).to eq("My first comment.")
      end

      it "includes the correct user" do
        expect(results.first["user_id"]).to eq(1)
      end
    end
  end

end
